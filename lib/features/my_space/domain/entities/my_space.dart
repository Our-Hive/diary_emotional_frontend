class MySpace {
  final String id;
  final String name;
  final MySpaceType type;
  final String url;
  final DateTime createdAt;

  MySpace({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.createdAt,
  });
}

enum MySpaceType {
  image,
  video,
}
