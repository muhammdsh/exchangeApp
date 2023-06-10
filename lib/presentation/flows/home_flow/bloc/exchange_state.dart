part of 'exchange_bloc.dart';

enum ExchangePageStatus { init, success, error, loading }

class ExchangeState extends Equatable {
  final ExchangePageStatus status;
  final List<CurrencyEntity> currenciesList;
  final List<CurrencyEntity> displayList;
  final String lastUpdate;
  final String error;

  ExchangeState({
    this.status = ExchangePageStatus.init,
    this.currenciesList = const [],
    this.displayList = const [],
    this.lastUpdate = "",
    this.error = "",
  });

  ExchangeState copyWith(
      {ExchangePageStatus status,
      String error,
      List<CurrencyEntity> currenciesList,
      List<CurrencyEntity> displayList,
      String lastUpdate}) {
    return ExchangeState(
        status: status ?? this.status,
        error: error ?? this.error,
        currenciesList: currenciesList ?? this.currenciesList,
        displayList: displayList ?? this.displayList,
        lastUpdate: lastUpdate ?? this.lastUpdate);
  }

  @override
  List<Object> get props => [status, currenciesList, lastUpdate, error,displayList];
}
