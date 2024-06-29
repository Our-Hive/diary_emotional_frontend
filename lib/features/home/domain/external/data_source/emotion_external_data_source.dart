import 'package:emotional_app/features/home/domain/entities/Emotion.dart';

abstract class EmotionExternalDataSource {
  Future<Set<Emotion>> getPrimaryEmotions();
}
