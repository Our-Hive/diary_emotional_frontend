import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';

abstract class HistoryExternalRepository {
  Future<List<Record>> getHistory({
    int page = 0,
  });

  Future<List<TrascendentalRecord>> getTrascendentalRecords({
    int page = 0,
  });

  Future<List<DailyRecord>> getDailyRecords({
    int page = 0,
  });
  Future<List<Record>> getHistoryByUserId({
    //int page = 0,
    required int userId,
  });
}
