part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState(
      {this.isLaunched = false,
      this.isFirstTime = false,
      this.checkProfile = false,
      this.language = AppLanguages.en,
      this.appThemeMode = AppThemeMode.light,
      this.cart = const CartState(),
      this.appStatus = Status.startup});

  final bool isFirstTime;
  final bool isLaunched;
  final AppLanguages language;
  final AppThemeMode appThemeMode;
  final CartState cart;
  final Status appStatus;
  final bool checkProfile;

  get isEnglish => language == AppLanguages.en;

  AppState copyWith({
    bool isLaunched,
    Status appStatus,
    AppLanguages language,
    AppThemeMode appThemeMode,
    bool isFirstTime,
    CartState cart,
    bool checkProfile,
  }) {
    return AppState(
      isLaunched: isLaunched ?? this.isLaunched,
      appThemeMode: appThemeMode ?? this.appThemeMode,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      appStatus: appStatus ?? this.appStatus,
      language: language ?? this.language,
      cart: cart ?? this.cart,
      checkProfile: checkProfile ?? this.checkProfile,
    );
  }

  @override
  List<Object> get props => [
        isLaunched,
        language,
        appThemeMode,
        isFirstTime,
        cart,
        appStatus,
        checkProfile
      ];
}

class CartState extends Equatable {
  const CartState(
      { this.itemsCount = 0, this.totalPrice = 0});

 // final List<CartItemEntity> items;
  final int itemsCount;
  final double totalPrice;

  CartState copyWith(
      { int itemsCount, double totalPrice}) {
    return CartState(
       // items: items ?? this.items,
        itemsCount: itemsCount ?? this.itemsCount,
        totalPrice: totalPrice ?? this.totalPrice);
  }

  @override
  List<Object> get props => [ itemsCount, totalPrice];
}
