import 'package:exchange/core/mediators/bloc_hub/member.dart';
import 'package:exchange/core/mediators/communication_types/base_communication.dart';

import 'bloc_member.dart';

abstract class BlocHub {
  List<Member> getTeamsMembers();

  void sendToByName(
        String senderName, CommunicationType data, String receiverName);

  void registerByName(BlocMember member, String name);

  void sendToAll(String senderName, CommunicationType data);
}
