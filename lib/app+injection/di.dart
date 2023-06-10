import 'package:dio/dio.dart';
import 'package:exchange/data/datasources/exchage_data_source/exchange_data_source.dart';
import 'package:exchange/data/repositories/exchange_reposotory_impl.dart';
import 'package:exchange/domain/usecases/convert_exchange_use_case.dart';
import 'package:exchange/domain/usecases/get_currencies_usecases.dart';
import 'package:exchange/presentation/flows/root_flow/bloc/root_bloc.dart';
import 'package:exchange/presentation/flows/root_flow/screens/root_page.dart';
import 'package:get_it/get_it.dart';
import 'package:exchange/core/api/auth_interceptor.dart';
import 'package:exchange/core/blocs/application_bloc/app_bloc.dart';
import 'package:exchange/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:exchange/core/mediators/bloc_hub/hub.dart';
import 'package:exchange/core/mediators/bloc_hub/members_key.dart';
import 'package:exchange/core/services/image_picker_service.dart';
import 'package:exchange/core/services/location_service.dart';
import 'package:exchange/core/services/session_manager.dart';
import 'package:exchange/core/services/theme_store.dart';
import 'package:exchange/core/usecases/app_theme_usecases.dart';
import 'package:exchange/core/usecases/check_first_initialize_usecase.dart';

import 'package:exchange/presentation/fa%C3%A7ades/app_facade.dart';

import '../core/services/init_app_store.dart';
import '../data/datasources/exchage_data_source/exchange_data_source_impl.dart';
import '../domain/repositories/exchange_repository.dart';
import '../presentation/flows/converter_flow/blocs/convert_bloc.dart';
import '../presentation/flows/home_flow/bloc/exchange_bloc.dart';


final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());

  locator.registerLazySingleton<ThemeStore>(() => ThemeStore());

  locator.registerLazySingleton<InitAppStore>(() => InitAppStore());

  locator.registerLazySingleton<SetAppThemeUseCase>(
      () => SetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<GetAppThemeUseCase>(
      () => GetAppThemeUseCase(locator<ThemeStore>()));

  locator.registerLazySingleton<CheckFirstInitUseCase>(
      () => CheckFirstInitUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<SetFirstTimeUseCase>(
      () => SetFirstTimeUseCase(locator<InitAppStore>()));

  locator.registerLazySingleton<SessionManager>(() => SessionManager());
  locator.registerFactory<Dio>(() => Dio());

  locator.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(locator<SessionManager>(), locator<Dio>()));





  locator.registerLazySingleton<AppUiFacade>(() => AppUiFacade(
        setAppThemeUseCase: locator<SetAppThemeUseCase>(),
        getAppThemeUseCase: locator<GetAppThemeUseCase>(),
        checkFirstInitUseCase: locator<CheckFirstInitUseCase>(),
        setFirstTimeUseCase: locator<SetFirstTimeUseCase>(),

      ));




  locator.registerLazySingleton<AppBloc>(
      () => AppBloc(appUiFacade: locator<AppUiFacade>()));

  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());


  locator
      .registerLazySingleton<ExchangeDataSource>(() => ExchangeDataSourceImpl());

  locator.registerLazySingleton<ExchangeRepository>(
      () => ExchangeRepositoryImpl(locator<ExchangeDataSource>()));

  locator.registerLazySingleton<GetCurrencyUseCase>(
      () => GetCurrencyUseCase(locator<ExchangeRepository>()));

  locator.registerLazySingleton(() => LocationService());

  locator.registerLazySingleton(
      () => ConvertExchangeUseCase());
  locator
      .registerLazySingleton(() => ConvertBloc(locator<ConvertExchangeUseCase>()));

  locator.registerLazySingleton(() => NavigationController());
  locator.registerLazySingleton(() => RootBloc());
  locator.registerLazySingleton(() =>
      ExchangeBloc(locator<GetCurrencyUseCase>()));

  locator<BlocHub>().registerByName(locator<AppBloc>(), MembersKeys.appBloc);
  locator<BlocHub>().registerByName(locator<RootBloc>(), MembersKeys.rootBloc);
  locator<BlocHub>()
      .registerByName(locator<ExchangeBloc>(), MembersKeys.exchangeBloc);
  locator<BlocHub>()
      .registerByName(locator<ConvertBloc>(), MembersKeys.convertBloc);
}
