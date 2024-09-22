import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';

class TrascendentalRecord extends Record {
  final String location;
  final String activity;
  final String companions;

  TrascendentalRecord({
    required super.id,
    required super.primaryEmotion,
    required super.secondaryEmotion,
    required super.date,
    required this.location,
    required this.activity,
    required this.companions,
  });

  factory TrascendentalRecord.empty() => TrascendentalRecord(
        id: '',
        primaryEmotion: Emotion.empty(),
        secondaryEmotion: Emotion.empty(),
        date: DateTime.now(),
        location: '',
        activity: '',
        companions: '',
      );
}
