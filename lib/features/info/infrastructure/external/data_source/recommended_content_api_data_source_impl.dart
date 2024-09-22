import 'package:emotional_app/config/http/go_http_singleton.dart';
import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';
import 'package:emotional_app/features/info/domain/external/data_source/recommended_content_external_data_source.dart';

class RecommendedContentApiDataSourceImpl
    implements RecommendedContentExternalDataSource {
  @override
  Future<List<RecommendedContent>> getRecommendedContent() async {
    final res = await GoHttpSingleton().get('/recommended-contact');
    // todo: mapping response to List<RecommendedContent> and return
    throw UnimplementedError();
  }
}
