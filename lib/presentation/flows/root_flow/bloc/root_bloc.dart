import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange/core/mediators/bloc_hub/bloc_member.dart';
import 'package:exchange/presentation/flows/root_flow/screens/root_page.dart';
import 'package:meta/meta.dart';
import 'package:exchange/core/mediators/communication_types/base_communication.dart';


part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> with BlocMember {
  RootBloc() : super(const RootState()) {
    on<NavigateEvent>(_onNavigate);
  }

  @override
  void receive(String from, CommunicationType data) {
    print('from : $from');
    if(data is TabCommunication) {
      navigateTo(data.rootTabs);
    }
  }
}

extension RootBlocMappers on RootBloc {

  void _onNavigate(
      NavigateEvent event, Emitter<RootState> emit) async {
    emit(state.copyWith(selectedTab: event.rootTabs));
  }

}

extension RootBlocActions on RootBloc {
  void navigateTo(RootTabs rootTabs) {
    add(NavigateEvent(rootTabs));
  }
}

class TabCommunication extends CommunicationType {
  final RootTabs rootTabs;

  TabCommunication(this.rootTabs);
}
