import 'package:emotional_app/features/records/history/domain/external/repository/history_external_repository.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/data_source/history_api_data_source_impl.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/repository/history_external_repository_impl.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supportNetworkHistoryProvider = StateNotifierProvider<
    SupportNetworkHistoryNotifier, SupportNetworkHistoryState>(
  (ref) => SupportNetworkHistoryNotifier(
    historyRepository: HistoryExternalRepositoryImpl(
      HistoryApiDataSourceImpl(),
    ),
  ),
);

class SupportNetworkHistoryNotifier
    extends StateNotifier<SupportNetworkHistoryState> {
  final HistoryExternalRepository _historyExternalRepository;

  SupportNetworkHistoryNotifier({
    required HistoryExternalRepository historyRepository,
  })  : _historyExternalRepository = historyRepository,
        super(SupportNetworkHistoryState());

  getHistoryByUser(int userId) async {
    try {
      final history = await _historyExternalRepository.getHistoryByUserId(
        userId: userId,
      );

      state = state.copyWith(
        history: history,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
      );
    }
  }
}

class SupportNetworkHistoryState {
  final List<Record> history;
  final String errorMessage;

  SupportNetworkHistoryState({
    this.history = const [],
    this.errorMessage = '',
  });

  SupportNetworkHistoryState copyWith({
    List<Record>? history,
    String? errorMessage,
  }) =>
      SupportNetworkHistoryState(
        history: history ?? this.history,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
