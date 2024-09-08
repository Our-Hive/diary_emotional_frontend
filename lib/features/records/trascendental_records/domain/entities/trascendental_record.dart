import 'package:emotional_app/features/home/domain/entities/emotion.dart';

class TrascendentalRecord {
  final Emotion primaryEmotion;
  final Emotion secondaryEmotion;
  final DateTime createdAt;
  final String location;
  final String activity;
  final String companion;
  final String description;

  TrascendentalRecord({
    required this.primaryEmotion,
    required this.secondaryEmotion,
    required this.createdAt,
    required this.location,
    required this.activity,
    required this.companion,
    required this.description,
  });
}
