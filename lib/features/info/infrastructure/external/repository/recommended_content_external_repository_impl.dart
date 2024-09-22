import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';
import 'package:emotional_app/features/info/domain/external/data_source/recommended_content_external_data_source.dart';
import 'package:emotional_app/features/info/domain/external/repository/recommended_content_external_repository.dart';

class RecommendedContentExternalRepositoryImpl
    implements RecommendedContentExternalRepository {
  final RecommendedContentExternalDataSource _dataSource;
  RecommendedContentExternalRepositoryImpl(this._dataSource);

  @override
  Future<List<RecommendedContent>> getRecommendedContent() {
    return _dataSource.getRecommendedContent();
  }
}
