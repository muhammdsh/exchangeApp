part of 'app_bloc.dart';

abstract class AppEvent {}

class LaunchAppEvent extends AppEvent {}

class AppLanguageEvent extends AppEvent {
  final AppLanguages languages;

  AppLanguageEvent(this.languages);
}

class AppThemeModeEvent extends AppEvent {
  final AppThemeMode appThemeMode;

  AppThemeModeEvent({this.appThemeMode});
}

class CheckUserEvent extends AppEvent{

}

class ChangeCheckUserEvent extends AppEvent{
  final bool data;
  ChangeCheckUserEvent({this.data});

}

abstract class CartEvent extends AppEvent {}

class AddToCartEvent extends CartEvent {
  final int id;
  final int productId;
  final int specificationId;
  final int quantity;
  final String name;
  final String image;

  AddToCartEvent(
      {this.id,
      this.productId,
      this.specificationId,
      this.quantity,
      this.name,
      this.image});
}

class RemoveFromCartEvent extends CartEvent {
  RemoveFromCartEvent(this.id);

  final int id;
}

class UpdateCartEvent extends CartEvent {


  final int id;
  final int productId;
  final int specificationId;
  final String name;
  final String image;
  final int newQuantity;

  UpdateCartEvent(
      {this.id,
      this.productId,
      this.specificationId,
      this.name,
      this.image,
      this.newQuantity});
}

class WatchItemsEvent extends CartEvent {}

// class GetItemsEvent extends AppEvent {
//   final List<CartItemEntity> items;
//
//   GetItemsEvent({this.items});
// }

class WatchItemsCountEvent extends CartEvent {

}


class GetItemsCountEvent extends CartEvent {
  final int count;

  GetItemsCountEvent(this.count);
}

class SetAppStatusEvent extends AppEvent {
  final AppStatus appStatus;
  final bool isFirstTime;

  SetAppStatusEvent(this.appStatus, {this.isFirstTime});
}

