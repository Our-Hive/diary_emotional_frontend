import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/domain/external/data_source/history_external_data_source.dart';
import 'package:emotional_app/features/records/history/domain/external/repository/history_external_repository.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';

class HistoryExternalRepositoryImpl implements HistoryExternalRepository {
  final HistoryExternalDataSource _dataSources;

  HistoryExternalRepositoryImpl(this._dataSources);
  @override
  Future<List<Record>> getHistory({int page = 0}) {
    return _dataSources.getHistory(page: page);
  }

  @override
  Future<List<DailyRecord>> getDailyHistory({int page = 0}) {
    return _dataSources.getDailyHistory(page: page);
  }

  @override
  Future<List<TrascendentalRecord>> getTrascendentalHistory({int page = 0}) {
    return _dataSources.getTrascendentalHistory(page: page);
  }
}
