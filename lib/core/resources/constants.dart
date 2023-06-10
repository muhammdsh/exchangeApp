import 'package:exchange/core/helper/extensions/material_color_converter.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TranslationsKeys {
  static String get changeLanguage => "change_lang";

  static String get changeTheme => "change_theme";

  static String get categories => "categories";

  static String get welcome => "welcome";

  static String get purpose => "purpose";

  static String get signIn => "signIn";

  static String get signUp => "signUp";

  static String get rightClothes => "right_clothes";

  static String get seeexchange => "see_exchange";

  static String get addLocation => "add_location";

  static String get useSearchBar => "use_search_bar";

  static String get cancel => "cancel";

  static String get findLocations => "find_locations";

  static String get myLocation => "my_location";

  static String get settings => "settings";

  static String get english => "english";

  static String get arabic => "arabic";

  static String get light => "light";

  static String get dark => "dark";

  static String get degree => "degree";

  static String get wind => "Wind";

  static String get pressure => "Pressure";

  static String get showDetails => "showDetails";

  static String get exchange => "exchange";
  static String get current => "current";
}

class ImagesKeys {
  static String get welcomeBackground => "lib/assets/welcomBg.png";

  static String get logo => "lib/assets/logo.png";

  
  static String get rain => "lib/assets/images/svg/ph_currency-circle-dollar-thin (1).svg";

  static String get rain1 => "lib/assets/images/svg/ant-design_gold-filled.svg";

  static String get rain2 => "lib/assets/images/svg/Group (1).svg";

  static String get rain3 => "lib/assets/images/svg/Group.svg";

  static String get search => "lib/assets/images/svg/ei_search.svg";

  static String get phoneCall => "lib/assets/images/svg/eva_phone-call-fill.svg";

  static String get flag => "lib/assets/images/svg/flag.svg";

  static String get downArrow => "lib/assets/images/svg/dashicons_arrow-right-alt2.svg";
  static String get switcher => "lib/assets/images/svg/switcher.svg";

  static String get bigLogo => "lib/assets/images/logo_my_change_big.png";

  static String get smallLogo => "lib/assets/images/logo_my_change_small.png";
}

class AppTheme {
  static ThemeData appThemeData(
      AppThemeColors appThemeColors, bool localeEn, Brightness brightness) {
    return ThemeData(
      backgroundColor: appThemeColors.backgroundColor,
      scaffoldBackgroundColor: appThemeColors.backgroundColor,
      primaryColor: appThemeColors.primaryColor,
      primaryColorLight: appThemeColors.primaryColor100,
     // colorScheme:ColorScheme(secondary:  appThemeColors.primaryColor) ,

      iconTheme: IconThemeData(color:  appThemeColors.primaryColor, size: 18.sp,),
      dividerTheme: DividerThemeData(color:appThemeColors.divider, thickness: 0.8 ),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: appThemeColors.primaryColor),
      textTheme: appTextTheme(),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: appThemeColors.text),
      ),
      primarySwatch: appThemeColors.primaryColor.toMaterialColor(),
      fontFamily: localeEn ? "roboto" : "cocon",
      brightness: brightness,
    );
  }

  static TextTheme appTextTheme() => TextTheme(
        displayLarge: TextStyle(fontSize: 57.sp,fontWeight: FontWeight.w400),
        displayMedium: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.w400),
        displaySmall: TextStyle(fontSize: 36.sp,fontWeight: FontWeight.w400),
        headlineLarge: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w400),
        headlineMedium: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w400),
        headlineSmall: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400),
        titleLarge: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w400 ),
        titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
      );
}
