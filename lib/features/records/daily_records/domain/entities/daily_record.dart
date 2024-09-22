import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';

class DailyRecord extends Record {
  final String description;

  DailyRecord({
    required super.id,
    required super.primaryEmotion,
    required super.secondaryEmotion,
    required super.date,
    required this.description,
  });

  factory DailyRecord.empty() => DailyRecord(
        id: '',
        primaryEmotion: Emotion.empty(),
        secondaryEmotion: Emotion.empty(),
        date: DateTime.now(),
        description: '',
      );
}
