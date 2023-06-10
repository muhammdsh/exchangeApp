import 'package:exchange/core/mediators/bloc_hub/bloc_member.dart';

class Member {
  String name;
  BlocMember child;

  Member(this.name, this.child);
}