import 'package:emotional_app/features/records/daily_records/domain/entities/daily_record.dart';
import 'package:emotional_app/features/records/history/domain/external/repository/history_external_repository.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/data_source/history_api_data_source_impl.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/exceptions/history_empty_exception.dart';
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
  bool maxPage = false;

  int currentPageT = 0;
  bool maxPageT = false;

  int currentPageD = 0;
  bool maxPageD = false;

  HistoryNotifier({
    required HistoryExternalRepository historyRepository,
  })  : _historyRepository = historyRepository,
        super(
          HistoryState.initial(),
        );

  Future<void> getHistory({refresh = false}) async {
    try {
      if (currentPage == 0 || refresh) {
        final records = await _historyRepository.getHistory();
        state = state.copyWith(
          records: records,
          errorMessages: '',
        );
      } else {
        loadNextPage();
      }
    } on HistoryEmptyException {
      if (state.records.isEmpty) {
        state = state.copyWith(
          errorMessages: 'No hay registros, ¡anímate a crear uno!',
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
    }
  }

  Future<void> getDailyRecords({refresh = false}) async {
    try {
      if (currentPage == 0 || refresh) {
        final records = await _historyRepository.getDailyRecords();
        state = state.copyWith(
          dailyRecords: records,
          errorMessages: '',
        );
      } else {
        loadNextPageDaily();
      }
    } on HistoryEmptyException {
      if (state.dailyRecords.isEmpty) {
        state = state.copyWith(
          errorMessages:
              'No hay registros diarios, ¡anímate a crear el primero!',
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
    }
  }

  Future<void> getTrascendentalRecords({refresh = false}) async {
    try {
      if (currentPage == 0 || refresh) {
        final records = await _historyRepository.getTrascendentalRecords();
        state = state.copyWith(
          trascendentalRecords: records,
          errorMessages: '',
        );
      } else {
        loadNextPageTrascendental();
      }
    } on HistoryEmptyException {
      if (state.trascendentalRecords.isEmpty) {
        state = state.copyWith(
          errorMessages:
              'No hay registros trascendentales, ¡anímate a crear uno!',
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessages: e.toString(),
      );
    }
  }

  TrascendentalRecord findTrascendentalRecord(String recordId) {
    try {
      final trascendentalRecord = state.trascendentalRecords
          .where((element) => element.id == recordId)
          .first;

      return trascendentalRecord;
    } on StateError catch (_) {
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
      final dailyRecord = state.dailyRecords
          .where(
            (element) => element.id == recordId,
          )
          .first;
      return dailyRecord;
    } on StateError catch (_) {
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

  Future<void> loadNextPageTrascendental() async {
    if (maxPageT) return;
    if (state.isLoading) return;
    state = state.copyWith(
      isLoading: true,
    );
    currentPageT++;
    final records = await _historyRepository.getTrascendentalRecords(
      page: currentPageT,
    );
    if (records.isEmpty) {
      maxPageT = true;
    }
    state = state.copyWith(
      trascendentalRecords: [...state.trascendentalRecords, ...records],
      errorMessages: '',
    );
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(
      isLoading: false,
    );
  }

  Future<void> loadNextPageDaily() async {
    if (maxPageD) return;
    if (state.isLoading) return;
    state = state.copyWith(
      isLoading: true,
    );
    currentPageD++;
    final records = await _historyRepository.getDailyRecords(
      page: currentPageD,
    );
    if (records.isEmpty) {
      maxPageD = true;
    }
    state = state.copyWith(
      dailyRecords: [...state.dailyRecords, ...records],
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
