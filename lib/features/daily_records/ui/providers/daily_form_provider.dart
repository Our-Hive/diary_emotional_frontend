import 'package:emotional_app/features/daily_records/domain/external/repository/daily_record_external_repository.dart';
import 'package:emotional_app/features/daily_records/infrastructure/external/data_source/daily_record_api_data_source.dart';
import 'package:emotional_app/features/daily_records/infrastructure/external/exceptions/cant_create_record_exception.dart';
import 'package:emotional_app/features/daily_records/infrastructure/external/exceptions/invalid_emotion_selected_exception.dart';
import 'package:emotional_app/features/daily_records/infrastructure/external/repository/daily_records_external_repository_impl.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dailyFormProvider =
    StateNotifierProvider<DailyFormNotifier, DailyFormState>(
  (ref) => DailyFormNotifier(
    emotionExternalRepo: DailyRecordsExternalRepositoryImpl(
      DailyRecordApiDataSource(),
    ),
  ),
);

class DailyFormNotifier extends StateNotifier<DailyFormState> {
  final DailyRecordExternalRepository _dailyRecordExternalRepo;

  DailyFormNotifier({
    required DailyRecordExternalRepository emotionExternalRepo,
  })  : _dailyRecordExternalRepo = emotionExternalRepo,
        super(DailyFormState(
          primaryEmotionSelected: Emotion.empty(),
          secondaryEmotionSelected: Emotion.empty(),
        ));

  void onPrimaryEmotionSelect(Emotion primaryEmotion) {
    _resetState();
    state = state.copyWith(primaryEmotionSelected: primaryEmotion);
  }

  void onSecondaryEmotionSelect(Emotion secondaryEmotion) {
    state = state.copyWith(secondaryEmotionSelected: secondaryEmotion);
  }

  void onDescriptionChange(String description) {
    state = state.copyWith(description: description);
  }

  Future<void> onFormSubmit() async {
    try {
      final isCreated = await _dailyRecordExternalRepo.addDailyRecord(
        primaryEmotion: state.primaryEmotionSelected.name,
        secondaryEmotion: state.secondaryEmotionSelected.name,
        description: state.description,
      );
      if (isCreated) {
        state = state.copyWith(status: DailyFormStatus.success);
      }
    } on InvalidEmotionSelectedException catch (e) {
      state = state.copyWith(
        status: DailyFormStatus.error,
        errorMessage: e.message,
      );
    } on CantCreateRecordException catch (e) {
      state = state.copyWith(
        status: DailyFormStatus.error,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: DailyFormStatus.error,
        errorMessage: 'Ha ocurrido un error al guardar el registro',
      );
    }
  }

  void _resetState() {
    state = state.copyWith(
      secondaryEmotionSelected: Emotion.empty(),
      description: '',
      status: DailyFormStatus.initial,
      errorMessage: '',
    );
  }
}

enum DailyFormStatus { initial, loading, success, error }

class DailyFormState {
  final Emotion primaryEmotionSelected;
  final Emotion secondaryEmotionSelected;
  final String description;
  final DailyFormStatus status;
  final String errorMessage;

  DailyFormState({
    required this.primaryEmotionSelected,
    required this.secondaryEmotionSelected,
    this.description = '',
    this.status = DailyFormStatus.initial,
    this.errorMessage = '',
  });

  DailyFormState copyWith({
    Emotion? primaryEmotionSelected,
    Emotion? secondaryEmotionSelected,
    String? description,
    DailyFormStatus? status,
    String? errorMessage,
  }) =>
      DailyFormState(
        primaryEmotionSelected:
            primaryEmotionSelected ?? this.primaryEmotionSelected,
        secondaryEmotionSelected:
            secondaryEmotionSelected ?? this.secondaryEmotionSelected,
        description: description ?? this.description,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
