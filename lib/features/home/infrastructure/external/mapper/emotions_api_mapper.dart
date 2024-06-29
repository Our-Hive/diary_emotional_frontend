import 'package:emotional_app/features/home/domain/entities/Emotion.dart';
import 'package:emotional_app/features/home/infrastructure/external/dto/get_primary_emotion_response_dto.dart';

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
}
