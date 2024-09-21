import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';

abstract class HistoryExternalDataSource {
  Future<List<Record>> getHistory({int page = 0});
  Future<List<DailyRecord>> getDailyHistory({int page = 0});
  Future<List<TrascendentalRecord>> getTrascendentalHistory({int page = 0});
}
