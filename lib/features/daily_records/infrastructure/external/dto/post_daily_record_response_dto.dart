class PostDailyRecordResponseDto {
  final String primaryEmotion;
  final String secondaryEmotion;
  final String description;
  final User user;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  PostDailyRecordResponseDto({
    required this.primaryEmotion,
    required this.secondaryEmotion,
    required this.description,
    required this.user,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory PostDailyRecordResponseDto.fromJson(Map<String, dynamic> json) =>
      PostDailyRecordResponseDto(
        primaryEmotion: json["primaryEmotion"],
        secondaryEmotion: json["secondaryEmotion"],
        description: json["description"],
        user: User.fromJson(json["user"]),
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "primaryEmotion": primaryEmotion,
        "secondaryEmotion": secondaryEmotion,
        "description": description,
        "user": user.toJson(),
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class User {
  final int id;

  User({
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
