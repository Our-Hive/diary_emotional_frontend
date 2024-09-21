import 'package:emotional_app/features/home/domain/entities/emotion.dart';

abstract class Record {
  final String id;
  final Emotion primaryEmotion;
  final Emotion secondaryEmotion;
  final DateTime date;

  Record({
    required this.id,
    required this.primaryEmotion,
    required this.secondaryEmotion,
    required this.date,
  });
}
