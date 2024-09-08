import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';

abstract class TrascendentalRecordsExternalRepository {
  Future<bool> addTrascendentalRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String location,
    required String activity,
    required String companion,
  });

  Future<List<TrascendentalRecord>> getTrascendentalRecords();
}
