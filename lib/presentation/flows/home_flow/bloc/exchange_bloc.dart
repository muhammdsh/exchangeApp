import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange/core/mediators/bloc_hub/bloc_member.dart';
import 'package:exchange/core/mediators/bloc_hub/members_key.dart';
import 'package:exchange/core/mediators/communication_types/base_communication.dart';
import 'package:exchange/core/param/no_param.dart';
import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:exchange/domain/usecases/get_currencies_usecases.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> with BlocMember {
  final GetCurrencyUseCase getCurrencyUseCase;

  ExchangeBloc(this.getCurrencyUseCase) : super(ExchangeState()) {
    on<GetCurrenciesEvent>(_onGetCurrencies);
    on<SearchCurrenciesEvent>(_onSearchCurrencies);
  }

  @override
  void receive(String from, CommunicationType data) {
    // if (data is exchangeLocation) {
    //   setLocation(locationEntity: data.locationEntity, unit: state.unit);
    // }
  }
}

extension ExchangeBlocMappers on ExchangeBloc {
  void _onGetCurrencies(GetCurrenciesEvent event, Emitter<ExchangeState> emit) async {

    emit(state.copyWith(
      status: ExchangePageStatus.loading,
    ));
    sendTo(ExchangeStatusConnection(ExchangePageStatus.loading), MembersKeys.convertBloc);
    final result = await getCurrencyUseCase(NoParams());
    if (result.hasDataOnly) {
      emit(state.copyWith(
          currenciesList: result.data.currencies,
          displayList: result.data.currencies,
          lastUpdate: result.data.lastUpdate,
          status: ExchangePageStatus.success));

      sendTo(ExchangeDataConnection(result.data.currencies, result.data.lastUpdate),
          MembersKeys.convertBloc);
      sendTo(ExchangeStatusConnection(ExchangePageStatus.success), MembersKeys.convertBloc);
    } else {
      emit(state.copyWith(status: ExchangePageStatus.error, error: "Something Went Wrong"));
      sendTo(ExchangeStatusConnection(ExchangePageStatus.error), MembersKeys.convertBloc);
    }
  }

  void _onSearchCurrencies(SearchCurrenciesEvent event, Emitter<ExchangeState> emit) async {
    if (state.currenciesList.isNotEmpty) {
      if (event.data.isNotEmpty) {
        final filteredList = state.currenciesList
            .where((element) =>
                element.currency.toLowerCase().contains(event.data.toLowerCase()) ||
                element.code.toLowerCase().contains(event.data.toLowerCase()))
            .toList();
        emit(state.copyWith(displayList: filteredList));
      } else {
        emit(state.copyWith(displayList: state.currenciesList));
      }
    }
  }

}

extension ExchangeBlocActions on ExchangeBloc {
  void getCurrencies() {
    add(GetCurrenciesEvent());
  }

  void searchCurrencies(String data) {
    add(SearchCurrenciesEvent(data: data));
  }
}

class ExchangeStatusConnection extends CommunicationType {
  final ExchangePageStatus exchangePageStatus;

  ExchangeStatusConnection(this.exchangePageStatus);
}

class ExchangeDataConnection extends CommunicationType {
  final List<CurrencyEntity> currencies;
  final String lastUpdate;

  ExchangeDataConnection(this.currencies, this.lastUpdate);
}
