import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/domain/external/data_source/emotion_external_data_source.dart';
import 'package:emotional_app/features/home/infrastructure/external/dto/get_primary_emotion_response_dto.dart';
import 'package:emotional_app/features/home/infrastructure/external/dto/get_secondary_emotion_response_dto.dart';
import 'package:emotional_app/features/home/infrastructure/external/mapper/emotions_api_mapper.dart';
import 'package:emotional_app/shared/infrastructure/exceptions/http_exception.dart';

class EmotionApiDataSource implements EmotionExternalDataSource {
  @override
  Future<Set<Emotion>> getPrimaryEmotions() async {
    try {
      final response = await AppHttpSingleton().get('/emotions/primary');
      final data = response.data as List<dynamic>;
      final List<GetPrimaryEmotionResponseDto> emotions =
          data.map((e) => GetPrimaryEmotionResponseDto.fromJson(e)).toList();
      return EmotionsApiMapper.fromGetPrimaryEmotionResponseDto(emotions)
          .toSet();
    } catch (e) {
      throw HttpException();
    }
  }

  @override
  Future<List<Emotion>> getSecondaryEmotions(String primaryEmotionName) async {
    try {
      final response = await AppHttpSingleton().get(
        '/emotions/primary/$primaryEmotionName',
      );
      return EmotionsApiMapper.fromGetSecondaryEmotionResponseDto(
        GetSecondaryEmotionResponseDto.fromJson(response.data),
      );
    } catch (e) {
      throw HttpException();
    }
  }
}
