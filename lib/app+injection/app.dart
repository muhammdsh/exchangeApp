import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/blocs/application_bloc/app_bloc.dart';
import 'package:exchange/core/localization/app_lang.dart';
import 'package:exchange/core/mediators/communication_types/AppStatus.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/presentation/flows/root_flow/screens/root_page.dart';
import 'package:exchange/presentation/flows/startup_flow/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/resources/constants.dart';


class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appBloc = locator<AppBloc>();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    appBloc.add(LaunchAppEvent());
  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previousState, state) {
          return previousState.cart == state.cart;
        },
        builder: (context, state) {
          if (locator.isRegistered<AppThemeColors>()) {
            locator.unregister<AppThemeColors>();
          }
          locator.registerFactory<AppThemeColors>(
              () => ThemeFactory.colorModeFactory(state.appThemeMode));

          return ScreenUtilInit(
              designSize: const Size(414, 896),
              minTextAdapt: true,
              splitScreenMode: true,
              child: state.appStatus == Status.startup ? SplashScreen() : RootPageWidget(),
              builder: (context, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'exchange',
                  theme: AppTheme.appThemeData(
                      locator<AppThemeColors>(), state.isEnglish, Brightness.light),
                  darkTheme: AppTheme.appThemeData(
                      locator<AppThemeColors>(), state.isEnglish, Brightness.dark),
                  themeMode: ThemeFactory.currentTheme(state.appThemeMode),
                  locale: LocalizationManager.localeFactory(state.language),
                  localizationsDelegates: LocalizationManager.createLocalizationsDelegates,
                  supportedLocales: LocalizationManager.createSupportedLocals,
                  home: child,
                );
              });
        },
      ),
    );
  }
}

