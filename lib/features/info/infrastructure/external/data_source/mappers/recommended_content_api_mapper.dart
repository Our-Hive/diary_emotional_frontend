import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/dtos/get_recommended_content_response_dto.dart';

class RecommendedContentApiMapper {
  static List<RecommendedContent> fromGetRecommendedContentResponseDto(
      List<GetRecommendedContentResponseDto> jsonList) {
    return jsonList
        .map((e) => RecommendedContent(
              title: e.title,
              description: e.description,
              url: e.url,
            ))
        .toList();
  }
}
