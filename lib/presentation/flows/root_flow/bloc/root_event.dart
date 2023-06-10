part of 'root_bloc.dart';

@immutable
abstract class RootEvent {}

class NavigateEvent extends RootEvent {

  final RootTabs rootTabs;

  NavigateEvent(this.rootTabs);
}
