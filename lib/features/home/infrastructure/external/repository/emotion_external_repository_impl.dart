import 'package:emotional_app/features/home/domain/entities/Emotion.dart';
import 'package:emotional_app/features/home/domain/external/data_source/emotion_external_data_source.dart';
import 'package:emotional_app/features/home/domain/external/repository/emotion_external_repository.dart';

class EmotionExternalRepositoryImpl implements EmotionExternalRepository {
  final EmotionExternalDataSource _dataSource;
  EmotionExternalRepositoryImpl(this._dataSource);
  @override
  Future<Set<Emotion>> getPrimaryEmotions() {
    return _dataSource.getPrimaryEmotions();
  }
}
