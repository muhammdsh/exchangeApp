import 'package:exchange/core/mediators/bloc_hub/bloc_member.dart';
import 'package:exchange/core/mediators/bloc_hub/hub.dart';
import 'package:exchange/core/mediators/bloc_hub/member.dart';
import 'package:exchange/core/mediators/communication_types/base_communication.dart';

class ConcreteHub extends BlocHub {
  final Map _blocMembersMap = <String, BlocMember>{};

  @override
  List<Member> getTeamsMembers() =>
      _blocMembersMap.entries.map((entry) => entry.value).toList();


  @override
  void sendToAll(String senderName, CommunicationType data) {
    final filteredMembers = _blocMembersMap.entries
        .map((entry) => Member(entry.key, entry.value))
        .toList()
        .where((element) => element.name != senderName);

    for (final member in filteredMembers) {
      member.child.receive(senderName, data);
    }
  }


  @override
  void sendToByName(
      String senderName, CommunicationType data, String receiverName) {

    if(_blocMembersMap.containsKey(receiverName)) {
      _blocMembersMap[receiverName].receive(senderName, data);
    }
    return;
  }

  @override
  void registerByName(BlocMember member, String name) {
    member.blocHub = this;
    member.name = name;

    _blocMembersMap[name] = member;
  }
}
