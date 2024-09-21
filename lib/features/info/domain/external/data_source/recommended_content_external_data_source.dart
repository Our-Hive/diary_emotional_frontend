import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';

abstract class RecommendedContentExternalDataSource {
  Future<List<RecommendedContent>> getRecommendedContent();
}
