part of 'convert_bloc.dart';

enum LocationStatus { initial, success, failure, loading }

class ConvertState extends Equatable {
  final ExchangePageStatus status;
  final List<CurrencyEntity> first;
  final List<CurrencyEntity> second;
  final CurrencyEntity fromCurrency;
  final CurrencyEntity toCurrency;
  final String fromAmount;
  final String toAmount;
  final bool isSwitched;
  final String lastUpdate;
  final bool isError;
  final String error;

  const ConvertState(
      {this.status = ExchangePageStatus.init,
      this.first = const [],
      this.second = const [],
      this.fromCurrency,
      this.toCurrency,
      this.fromAmount = "",
      this.toAmount = "",
      this.lastUpdate = "",
      this.isSwitched = false,
      this.isError,
      this.error});

  ConvertState copyWith(
      {ExchangePageStatus status,
      List<CurrencyEntity> first,
      List<CurrencyEntity> second,
      CurrencyEntity fromCurrency,
      CurrencyEntity toCurrency,
      String fromAmount,
      String toAmount,
      String lastUpdate,
      bool isSwitched,
      bool isError,
      String error}) {
    return ConvertState(
        status: status ?? this.status,
        first: first ?? this.first,
        second: second ?? this.second,
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        fromAmount: fromAmount ?? this.fromAmount,
        toAmount: toAmount ?? this.toAmount,
        isSwitched: isSwitched ?? this.isSwitched,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        isError: isError ?? this.isError,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [
        status,
        first,
        fromCurrency,
        toCurrency,
        toAmount,
        fromAmount,
        second,
        lastUpdate,
        error,
        isError,
        isSwitched
      ];
}
