class GetPrimaryEmotionResponseDto {
  final String name;
  final String description;
  final String color;
  final String theme;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  GetPrimaryEmotionResponseDto({
    required this.name,
    required this.description,
    required this.color,
    required this.theme,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory GetPrimaryEmotionResponseDto.fromJson(Map<String, dynamic> json) =>
      GetPrimaryEmotionResponseDto(
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
