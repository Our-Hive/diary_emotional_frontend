import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/external/data_source/trascendental_records_external_data_source.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/external/repository/trascendental_records_external_repository.dart';

class TrascendentalRecordsExternalRepositoryImpl
    implements TrascendentalRecordsExternalRepository {
  final TrascendentalRecordsExternalDataSource _dataSource;
  TrascendentalRecordsExternalRepositoryImpl(this._dataSource);
  @override
  Future<bool> addTrascendentalRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String location,
    required String activity,
    required String companion,
  }) {
    return _dataSource.addTrascendentalRecord(
      primaryEmotion: primaryEmotion,
      secondaryEmotion: secondaryEmotion,
      location: location,
      activity: activity,
      companion: companion,
    );
  }

  @override
  Future<List<TrascendentalRecord>> getTrascendentalRecords() {
    return _dataSource.getTrascendentalRecords();
  }
}
