import 'package:emotional_app/config/http/go_http_singleton.dart';
import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';
import 'package:emotional_app/features/info/domain/external/data_source/recommended_content_external_data_source.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/dtos/get_recommended_content_response_dto.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/mappers/recommended_content_api_mapper.dart';

class RecommendedContentApiDataSourceImpl
    implements RecommendedContentExternalDataSource {
  @override
  Future<List<RecommendedContent>> getRecommendedContent() async {
    try {
      final res = await GoHttpSingleton().get('/recommended-content');

      final List<GetRecommendedContentResponseDto> dto = (res.data as List)
          .map((e) => GetRecommendedContentResponseDto.fromJson(e))
          .toList();
      return RecommendedContentApiMapper.fromGetRecommendedContentResponseDto(
        dto,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
