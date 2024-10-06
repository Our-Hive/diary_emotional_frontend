import 'package:emotional_app/features/support_network/domain/entities/support_network_member.dart';

abstract class SupportNetworkExternalRepository {
  Future<bool> addSupportNetworkByUserName(
    String userName,
  );
  Future<List<SupportNetworkMember>> getSupportNetwork();
}
