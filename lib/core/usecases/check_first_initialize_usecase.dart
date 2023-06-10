import 'package:exchange/core/param/base_param.dart';

import '../param/no_param.dart';
import '../services/init_app_store.dart';
import 'base_use_case.dart';

class CheckFirstInitUseCase extends UseCase<Future<bool>, NoParams> {

  final InitAppStore initAppStore;

  CheckFirstInitUseCase(this.initAppStore);

  @override
  Future<bool> call(NoParams params) async {
    return await initAppStore.isFirstTime;
  }
}

class SetFirstTimeUseCase extends UseCase<void, NoParams> {

  final InitAppStore initAppStore;

  SetFirstTimeUseCase(this.initAppStore);

  @override
  void call(NoParams params) {
    initAppStore.setFirstTime();
  }
}
