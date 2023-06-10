import 'package:flutter/material.dart';

enum AppThemeMode { dark, light }

abstract class  AppThemeColors {
  Color get primaryColor;

  Color get primaryColor100;
  Color get primaryColor400;

  Color get grey;

  Color get text;

  Color get backgroundColor;

  Color get surface;

  Color get white;

  Color get black;

  Color get secondaryColor;

  Color get accentColor;

  Color get transparent;
  Color get divider;

  List<Color> get gradientColor;

  Color get gradientStarts;
  Color get gradientEnds;
}

class LightModeColors extends AppThemeColors {
  @override
  Color get primaryColor => const Color(0xff513070);

  @override
  Color get primaryColor100 => const Color(0xffc9bfd3);

  @override
  Color get backgroundColor => const Color(0xffffffff);

  @override
  Color get grey => const Color(0xff7a767a);

  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get secondaryColor => const Color(0xff623B85);

  @override
  Color get accentColor => const Color(0xffe6e6e6);

  @override
  Color get text => const Color(0xff2E2E2E);

  @override
  Color get transparent => Colors.transparent;

  @override
  Color get surface => const Color(0xfff2f1f2);

  @override
  List<Color> get gradientColor => [primaryColor, const Color(0xff331F46)];

  @override
  Color get gradientStarts => primaryColor ;

  @override
  Color get gradientEnds => const Color(0xff331F46);

  @override
  Color get divider => const Color(0x5EC7C8C8);

  @override
  Color get primaryColor400 => const Color(0xff74598d);





}

class DarkModeColors extends AppThemeColors {
  @override
  Color get primaryColor => const Color(0xff333333);

  @override
  Color get primaryColor100 => const Color(0xff8a749f);

  @override
  Color get backgroundColor => const Color(0xFF242424);

  @override
  Color get grey => Colors.grey;

  @override
  Color get white => Colors.white;

  @override
  Color get black => Colors.black;

  @override
  Color get secondaryColor => const Color(0xff8a749f);

  @override
  Color get accentColor => const Color(0xffe6e6e6);

  @override
  Color get text => const Color(0xffc2c0c2);

  @override
  Color get transparent => Colors.transparent;

  @override
  Color get surface => const Color(0xff434143);

  @override
  Color get primaryColor400 => const Color(0xffafa0bd);

  @override
  List<Color> get gradientColor => [const Color(0xff513070), const Color(0xff331F46)];

  @override
  Color get gradientStarts => const Color(0xff513070);

  @override
  Color get gradientEnds => const Color(0xff331F46);

  @override
  Color get divider => const Color(0x5EC7C8C8);
}

class ThemeFactory {
  static AppThemeColors colorModeFactory(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return LightModeColors();
      case AppThemeMode.dark:
        return DarkModeColors();
      default:
        return LightModeColors();
    }
  }

  static ThemeMode currentTheme(AppThemeMode appThemeMode) {
    return appThemeMode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
