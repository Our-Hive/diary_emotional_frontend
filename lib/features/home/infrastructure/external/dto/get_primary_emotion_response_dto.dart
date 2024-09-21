import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/shared/infrastructure/http/emotion_parser.dart';

class GetPrimaryEmotionResponseDto {
  final String name;
  final String description;
  final String color;
  final EmotionTheme theme;
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
        theme: themeValues.map[json["theme"]]!,
        secondaryEmotions: json["secondaryEmotions"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "color": color,
        "theme": themeValues.reverse[theme],
        "secondaryEmotions": secondaryEmotions,
      };
}
