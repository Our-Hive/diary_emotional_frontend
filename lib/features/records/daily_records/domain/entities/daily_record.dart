import 'package:emotional_app/features/home/domain/entities/emotion.dart';

class DailyRecord {
  Emotion primaryEmotion;
  Emotion secondaryEmotion;
  DateTime createdAt;
  String description;

  DailyRecord({
    required this.primaryEmotion,
    required this.secondaryEmotion,
    required this.createdAt,
    required this.description,
  });
}
