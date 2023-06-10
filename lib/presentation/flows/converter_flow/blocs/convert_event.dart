part of 'convert_bloc.dart';

@immutable
abstract class ConvertEvent {}

class SetDataEvent extends ConvertEvent{

  final ExchangePageStatus status;
  final List<CurrencyEntity> first;
  final List<CurrencyEntity> second;
  final CurrencyEntity fromCurrency;
  final CurrencyEntity toCurrency;
  final String fromAmount;
  final String toAmount;
  final bool isSwitched;
  final String lastUpdate;

  SetDataEvent(
      {this.status,
      this.first,
      this.second,
      this.fromCurrency,
      this.toCurrency,
      this.fromAmount,
      this.toAmount,
      this.isSwitched,
      this.lastUpdate});
}

class ApplyConvertEvent extends ConvertEvent {

}

class ResetConvertEvent extends ConvertEvent {

}



