import 'package:emotional_app/features/records/record/domain/entities/record.dart';

abstract class HistoryExternalDataSource {
  Future<List<Record>> getHistory({int page = 0});
}
