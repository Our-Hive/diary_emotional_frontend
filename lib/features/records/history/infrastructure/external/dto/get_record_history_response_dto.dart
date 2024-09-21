import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/shared/infrastructure/http/emotion_parser.dart';

class GetRecordHistoryResponseDto {
  final int id;
  final String? description;
  final DateTime createdAt;
  final AryEmotion primaryEmotion;
  final AryEmotion secondaryEmotion;
  final String? location;
  final String? activity;
  final String? companion;
  final DateTime? date;

  GetRecordHistoryResponseDto({
    required this.id,
    this.description,
    required this.createdAt,
    required this.primaryEmotion,
    required this.secondaryEmotion,
    this.location,
    this.activity,
    this.companion,
    this.date,
  });

  factory GetRecordHistoryResponseDto.fromJson(Map<String, dynamic> json) =>
      GetRecordHistoryResponseDto(
        id: json["id"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        primaryEmotion: AryEmotion.fromJson(json["primaryEmotion"]),
        secondaryEmotion: AryEmotion.fromJson(json["secondaryEmotion"]),
        location: json["location"],
        activity: json["activity"],
        companion: json["companion"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "primaryEmotion": primaryEmotion.toJson(),
        "secondaryEmotion": secondaryEmotion.toJson(),
        "location": location,
        "activity": activity,
        "companion": companion,
        "date": date?.toIso8601String(),
      };
}

class AryEmotion {
  final String name;
  final String description;
  final String color;
  final EmotionTheme theme;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  AryEmotion({
    required this.name,
    required this.description,
    required this.color,
    required this.theme,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory AryEmotion.fromJson(Map<String, dynamic> json) => AryEmotion(
        name: json["name"],
        description: json["description"],
        color: json["color"],
        theme: themeValues.map[json["theme"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "color": color,
        "theme": themeValues.reverse[theme],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
