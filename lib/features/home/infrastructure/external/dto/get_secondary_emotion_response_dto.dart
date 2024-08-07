class GetSecondaryEmotionResponseDto {
  final String name;
  final String description;
  final List<SecondaryEmotion> secondaryEmotions;

  GetSecondaryEmotionResponseDto({
    required this.name,
    required this.description,
    required this.secondaryEmotions,
  });

  factory GetSecondaryEmotionResponseDto.fromJson(Map<String, dynamic> json) =>
      GetSecondaryEmotionResponseDto(
        name: json["name"],
        description: json["description"],
        secondaryEmotions: List<SecondaryEmotion>.from(
            json["secondaryEmotions"].map((x) => SecondaryEmotion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "secondaryEmotions":
            List<dynamic>.from(secondaryEmotions.map((x) => x.toJson())),
      };
}

class SecondaryEmotion {
  final String name;
  final String description;
  final String color;
  final String theme;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  SecondaryEmotion({
    required this.name,
    required this.description,
    required this.color,
    required this.theme,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory SecondaryEmotion.fromJson(Map<String, dynamic> json) =>
      SecondaryEmotion(
        name: json["name"],
        description: json["description"],
        color: json["color"],
        theme: json["theme"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "color": color,
        "theme": theme,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
