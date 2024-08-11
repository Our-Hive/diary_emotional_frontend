import 'package:emotional_app/features/home/domain/entities/emotion.dart';

abstract class EmotionExternalRepository {
  Future<Set<Emotion>> getPrimaryEmotions();
  Future<List<Emotion>> getSecondaryEmotions(String primaryEmotionName);
}
