import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/domain/external/repository/history_external_repository.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/data_source/history_api_data_source_impl.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/repository/history_external_repository_impl.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';

final historyProvider = StateNotifierProvider<HistoryNotifier, HistoryState>(
  (ref) => HistoryNotifier(
    historyRepository: HistoryExternalRepositoryImpl(
      HistoryApiDataSourceImpl(),
    ),
  ),
);

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryExternalRepository _historyRepository;
  int currentPage = 0;
  // todo: remove this verifying if it's the last page.
  bool maxPage = false;

  HistoryNotifier({
    required HistoryExternalRepository historyRepository,
  })  : _historyRepository = historyRepository,
        super(
          HistoryState.initial(),
        );

  Future<void> getHistory() async {
    try {
      if (currentPage == 0) {
        final records = await _historyRepository.getHistory();
        state = state.copyWith(
          records: records,
          errorMessages: '',
        );
      } else {
        loadNextPage();
      }
    } catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
    }
  }

  Future<void> getDailyRecords() async {
    try {} catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
    }
  }

  Future<void> getTrascendentalRecords() async {
    try {} catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
    }
  }

  TrascendentalRecord findTrascendentalRecord(String recordId) {
    try {
      final record = state.records
          .where((element) => element.id == recordId)
          .first as TrascendentalRecord;
      return record;
    } catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
      return TrascendentalRecord.empty();
    }
  }

  DailyRecord findDailyRecord(String recordId) {
    try {
      final record = state.records
          .where((element) => element.id == recordId)
          .first as DailyRecord;
      return record;
    } catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
      return DailyRecord.empty();
    }
  }

  Future<void> loadNextPage() async {
    if (maxPage) return;
    if (state.isLoading) return;
    state = state.copyWith(
      isLoading: true,
    );
    currentPage++;
    final records = await _historyRepository.getHistory(page: currentPage);
    if (records.isEmpty) {
      maxPage = true;
    }
    state = state.copyWith(
      records: [...state.records, ...records],
      errorMessages: '',
    );
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(
      isLoading: false,
    );
  }
}

class HistoryState {
  final List<Record> records;
  final List<DailyRecord> dailyRecords;
  final List<TrascendentalRecord> trascendentalRecords;
  final String errorMessages;
  final bool isLoading;

  HistoryState({
    required this.records,
    required this.dailyRecords,
    required this.trascendentalRecords,
    required this.errorMessages,
    required this.isLoading,
  });

  factory HistoryState.initial() => HistoryState(
        records: [],
        dailyRecords: [],
        trascendentalRecords: [],
        errorMessages: '',
        isLoading: false,
      );

  HistoryState copyWith({
    List<Record>? records,
    List<DailyRecord>? dailyRecords,
    List<TrascendentalRecord>? trascendentalRecords,
    String? errorMessages,
    bool? isLoading,
  }) {
    return HistoryState(
      records: records ?? this.records,
      dailyRecords: dailyRecords ?? this.dailyRecords,
      trascendentalRecords: trascendentalRecords ?? this.trascendentalRecords,
      errorMessages: errorMessages ?? this.errorMessages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
