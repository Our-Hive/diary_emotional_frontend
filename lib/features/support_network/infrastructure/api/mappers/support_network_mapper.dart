import 'package:dio/dio.dart';
import 'package:emotional_app/features/support_network/domain/entities/support_network_member.dart';

class SupportNetworkMapper {
  static List<SupportNetworkMember> fromResponse(
    List<Response<dynamic>> response,
  ) {
    final responseMySupports = response[0];
    final responseSupported = response[1];

    if (responseMySupports.statusCode == 200 &&
        responseSupported.statusCode == 200) {
      final List<SupportNetworkMember> supportNetworkMembers = [];
      final List<SupportNetworkMember> supportNetworkMembersInTheirNetwork = [];
      for (final supportMember in responseMySupports.data) {
        supportNetworkMembers.add(
          SupportNetworkMember(
            id: supportMember['id'],
            name: "${supportMember['firstName']} ${supportMember['lastName']}",
            userName: supportMember['username'],
            type: SupportNetworkType.inMyNetwork,
          ),
        );
      }
      for (final supportMember in responseSupported.data) {
        final indexRepeated = supportNetworkMembers.indexWhere(
          (element) => element.id == supportMember['id'],
        );
        if (indexRepeated != -1) {
          final repeatedMember = supportNetworkMembers[indexRepeated];
          repeatedMember.changeType(SupportNetworkType.mutualNetwork);
          continue;
        }

        supportNetworkMembersInTheirNetwork.add(
          SupportNetworkMember(
            id: supportMember['id'],
            name: "${supportMember['firstName']} ${supportMember['lastName']}",
            userName: supportMember['username'],
            type: SupportNetworkType.inTheirNetwork,
          ),
        );
      }

      return supportNetworkMembers;
    }
    throw Exception();
  }
}
