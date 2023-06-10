part of 'exchange_bloc.dart';


@immutable
abstract class ExchangeEvent {}

class GetCurrenciesEvent extends ExchangeEvent {

}

class SearchCurrenciesEvent extends ExchangeEvent {
  final String data;

  SearchCurrenciesEvent({this.data});
}

