import 'package:emotional_app/features/records/daily_records/domain/external/data_source/daily_record_external_data_source.dart';
import 'package:emotional_app/features/records/daily_records/domain/external/repository/daily_record_external_repository.dart';

class DailyRecordsExternalRepositoryImpl
    implements DailyRecordExternalRepository {
  final DailyRecordExternalDataSource _dataSource;
  DailyRecordsExternalRepositoryImpl(this._dataSource);

  @override
  Future<bool> addDailyRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String description,
  }) {
    return _dataSource.addDailyRecord(
      primaryEmotion: primaryEmotion,
      secondaryEmotion: secondaryEmotion,
      description: description,
    );
  }
}
