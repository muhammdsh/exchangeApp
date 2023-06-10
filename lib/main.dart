import 'package:exchange/core/error/http/forbidden_error.dart';
import 'package:exchange/core/services/memoization_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app+injection/app.dart';
import 'app+injection/di.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if(error is ForbiddenError) {
    //  locator<AuthBloc>().logout();
    }
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  MemoizationStore().reset();
  await setUpLocator();
  runApp(const App());
}
