class GetPrimaryEmotionResponseDto {
  final String name;
  final String description;
  final String color;
  final String theme;
  final dynamic secondaryEmotions;

  GetPrimaryEmotionResponseDto({
    required this.name,
    required this.description,
    required this.color,
    required this.theme,
    required this.secondaryEmotions,
  });

  factory GetPrimaryEmotionResponseDto.fromJson(Map<String, dynamic> json) =>
      GetPrimaryEmotionResponseDto(
        name: json["name"],
        description: json["description"],
        color: json["color"],
        theme: json["theme"],
        secondaryEmotions: json["secondaryEmotions"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "color": color,
        "theme": theme,
        "secondaryEmotions": secondaryEmotions,
      };
}
