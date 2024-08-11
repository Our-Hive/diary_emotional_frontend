import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/infrastructure/external/dto/get_primary_emotion_response_dto.dart';
import 'package:emotional_app/features/home/infrastructure/external/dto/get_secondary_emotion_response_dto.dart';

class EmotionsApiMapper {
  static List<Emotion> fromGetPrimaryEmotionResponseDto(
    List<GetPrimaryEmotionResponseDto> dto,
  ) =>
      dto
          .map(
            (e) => Emotion(
              name: e.name,
              description: e.description,
              color: e.color,
              colorBrightness: e.theme,
            ),
          )
          .toList();

  static List<Emotion> fromGetSecondaryEmotionResponseDto(
          GetSecondaryEmotionResponseDto dto) =>
      dto.secondaryEmotions
          .map((e) => Emotion(
                name: e.name,
                description: e.description,
                color: e.color,
                colorBrightness: e.theme,
              ))
          .toList();
}
