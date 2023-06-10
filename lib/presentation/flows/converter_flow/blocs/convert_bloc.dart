import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:exchange/core/mediators/bloc_hub/bloc_member.dart';
import 'package:exchange/core/mediators/bloc_hub/members_key.dart';
import 'package:exchange/core/mediators/communication_types/base_communication.dart';
import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange/presentation/flows/home_flow/bloc/exchange_bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:stream_transform/stream_transform.dart';

import '../../../../domain/usecases/convert_exchange_use_case.dart';

part 'convert_event.dart';

part 'convert_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> with BlocMember {
  final ConvertExchangeUseCase convertExchangeUseCase;

  ConvertBloc(this.convertExchangeUseCase) : super(const ConvertState()) {
    on<SetDataEvent>(
      _onSetData,
    );

    on<ApplyConvertEvent>(_onConvert);
    on<ResetConvertEvent>(_onReset);
  }

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  @override
  void receive(String from, CommunicationType data) {
    if (data is ExchangeStatusConnection) {
      setData(status: data.exchangePageStatus);
    } else if (data is ExchangeDataConnection) {
      setData(
          first: data.currencies,
          second: data.currencies,
          lastUpdate: data.lastUpdate,
          fromCurrency: data?.currencies?.first,
          toCurrency: data?.currencies?.first);
    }
  }
}

extension ConvertBlocMappers on ConvertBloc {
  void _onSetData(SetDataEvent event, Emitter<ConvertState> emit) async {
    emit(state.copyWith(
      status: event.status,
      first: event.first,
      second: event.second,
      fromCurrency: event.fromCurrency,
      toCurrency: event.toCurrency,
      fromAmount: event.fromAmount,
      toAmount: event.toAmount,
      isSwitched: event.isSwitched,
      lastUpdate: event.lastUpdate,
    ));

    if (state.fromCurrency != null && state.toCurrency != null) {
      convert();
    }
  }

  void _onReset(ResetConvertEvent event, Emitter<ConvertState> emit) async {
    emit(state.copyWith(
      fromAmount: 0.toString(),
      toAmount: 0.toString(),
    ));
  }

  void _onConvert(ApplyConvertEvent event, Emitter<ConvertState> emit) async {
    print('event: ${event}');
    if (!state.isSwitched) {
      if (state.fromAmount.isNumeric()) {
        final result = convertExchangeUseCase(ConvertExchangeParams(
          amount: double.parse(state.fromAmount),
          fromSellCurrency: double.parse(state.fromCurrency.sell),
          fromByCurrency: double.parse(state.fromCurrency.buy),
          toByCurrency: double.parse(state.toCurrency.buy),
          toSellCurrency: double.parse(state.toCurrency.sell),
        ));

        emit(state.copyWith(toAmount: result.toStringAsFixed(2)));
      } else if (state.fromAmount.isEmpty) {
        emit(state.copyWith(toAmount: 0.toString()));
      }
    } else {
      if (state.toAmount.isNumeric()) {
        final result = convertExchangeUseCase(ConvertExchangeParams(
          amount: double.parse(state.toAmount),
          fromSellCurrency: double.parse(state.toCurrency.sell),
          fromByCurrency: double.parse(state.toCurrency.buy),
          toByCurrency: double.parse(state.fromCurrency.buy),
          toSellCurrency: double.parse(state.fromCurrency.sell),
        ));

        emit(state.copyWith(fromAmount: result.toStringAsFixed(2)));
      } else if (state.toAmount.isEmpty) {
        emit(state.copyWith(fromAmount: 0.toString()));
      }
    }

    // emit(state.copyWith(selectedLocation: state.data[event.selectedLocationIndex]));
    //sendTo(exchangeLocation(state.data[event.selectedLocationIndex]), MembersKeys.exchangeBloc);
    // sendTo(TabCommunication(RootTabs.exchange), MembersKeys.rootBloc);
  }
}

extension ConvertBlocActions on ConvertBloc {
  void setData({
    ExchangePageStatus status,
    List<CurrencyEntity> first,
    List<CurrencyEntity> second,
    CurrencyEntity fromCurrency,
    CurrencyEntity toCurrency,
    String fromAmount,
    String toAmount,
    bool isSwitched,
    String lastUpdate,
  }) {
    add(SetDataEvent(
      status: status,
      first: first,
      second: second,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      fromAmount: fromAmount,
      toAmount: toAmount,
      isSwitched: isSwitched,
      lastUpdate: lastUpdate,
    ));
  }

  void convert() {
    add(ApplyConvertEvent());
  }

  void reset() {
    add(ResetConvertEvent());
  }
}

extension StringExtensions on String {
  bool isNumeric() {
    if (this == null) {
      return false;
    }
    return double.tryParse(this) != null;
  }
}
