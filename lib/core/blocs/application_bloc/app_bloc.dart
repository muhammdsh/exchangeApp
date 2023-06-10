import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange/core/localization/app_lang.dart';
import 'package:exchange/core/mediators/bloc_hub/bloc_member.dart';
import 'package:exchange/core/mediators/communication_types/AppStatus.dart';
import 'package:exchange/core/mediators/communication_types/base_communication.dart';
import 'package:exchange/core/mediators/communication_types/bool_type.dart';
import 'package:exchange/core/resources/colors.dart';

import '../../../presentation/façades/app_facade.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with BlocMember {
  final AppUiFacade appUiFacade;



  AppBloc({
    this.appUiFacade,
  }) : super(const AppState()) {
    /// App Events
    on<LaunchAppEvent>(_onLaunchApp);
    on<AppLanguageEvent>(_onAppLanguage);
    on<AppThemeModeEvent>(_onAppThemeMode);
    on<ChangeCheckUserEvent>(_changeProfileState);

    on<SetAppStatusEvent>(_onAppStatusChanged);

  }

  @override
  void receive(String from, CommunicationType data) {
    print("message Received $data");

    switch (data.runtimeType.toString()) {
      case 'AppStatus':
        print("in AppStatussss");
        setAppStatus(data);
        break;
      case 'BoolComType':
        add(ChangeCheckUserEvent(data: (data as BoolComType).data));
        break;
    }
  }
}

extension AppBlocMappers on AppBloc {
  // void _onCheckUser(CheckUserEvent event, Emitter<AppState> emit) async {
  //   if (state.appStatus == Status.authorized) {
  //   //  final checkProfileResult = await appUiFacade.checkUserProfile();
  //
  //     // if (checkProfileResult.hasDataOnly) {
  //     //   final resultData = checkProfileResult.data;
  //     //   emit(state.copyWith(checkProfile: resultData));
  //     // } else if (checkProfileResult.hasErrorOnly) {
  //     //   /// TODO: IMPLEMENT ERROR SNACK BAR TO SHOW ERROR
  //     //   /// emit(state.copyWith());
  //     // }
  //   } else {
  //     emit(state.copyWith(checkProfile: false));
  //   }
  // }

  void _onLaunchApp(LaunchAppEvent event, Emitter<AppState> emit) async {
    final appTheme = await appUiFacade.getAppTheme();
    final isFirstTime = await appUiFacade.isItFirstInit();
    if (isFirstTime) {
      appUiFacade.setFirstTime();
    }
    final appStatus = await appUiFacade.checkLoginStatus();

    await Future.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
          isLaunched: true,
          appThemeMode: appTheme,
          isFirstTime: isFirstTime,
          appStatus: appStatus),
    );
  }

  void _onAppStatusChanged(SetAppStatusEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(
        appStatus: event.appStatus.data, isFirstTime: event.isFirstTime));
  }

  void _changeProfileState(ChangeCheckUserEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(checkProfile: event.data));
  }

  void _onAppLanguage(AppLanguageEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(language: event.languages));
  }

  void _onAppThemeMode(AppThemeModeEvent event, Emitter<AppState> emit) async {
    AppThemeMode appThemeMode = _getContraryTheme(state.appThemeMode);
    emit(state.copyWith(appThemeMode: event.appThemeMode ?? appThemeMode));
    await appUiFacade.setAppTheme(event.appThemeMode ?? appThemeMode);
  }

  AppThemeMode _getContraryTheme(AppThemeMode currentMode) {
    return currentMode == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
  }
}



extension AppBLocActions on AppBloc {
  void changeLanguage(AppLanguages languages) {
    add(AppLanguageEvent(languages));
  }

  void changeTheme({AppThemeMode appThemeMode}) {
    add(AppThemeModeEvent(appThemeMode: appThemeMode));
  }

  void checkUserProfile() {
    add(CheckUserEvent());
  }
  void setAppStatus(AppStatus appStatus, {bool isFirstTime}) {
    add(SetAppStatusEvent(appStatus, isFirstTime: isFirstTime));
  }
}


