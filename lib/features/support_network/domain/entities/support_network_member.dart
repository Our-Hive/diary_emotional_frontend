class SupportNetworkMember {
  final int id;
  final String userName;
  final String name;
  SupportNetworkType type;

  SupportNetworkMember({
    required this.id,
    required this.userName,
    required this.name,
    required this.type,
  });

  void changeType(SupportNetworkType mutualNetwork) {
    type = mutualNetwork;
  }
}

enum SupportNetworkType {
  inMyNetwork,
  inTheirNetwork,
  mutualNetwork,
}
