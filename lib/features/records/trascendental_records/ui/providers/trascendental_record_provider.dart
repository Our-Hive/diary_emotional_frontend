import 'package:emotional_app/features/records/daily_records/infrastructure/external/exceptions/cant_create_record_exception.dart';
import 'package:emotional_app/features/records/daily_records/infrastructure/external/exceptions/invalid_emotion_selected_exception.dart';
import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/external/repository/trascendental_records_external_repository.dart';
import 'package:emotional_app/features/records/trascendental_records/infrastructure/external/data_source/trascendental_records_api_data_source.dart';
import 'package:emotional_app/features/records/trascendental_records/infrastructure/external/repository/trascendental_records_external_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trascendentalFormProvider =
    StateNotifierProvider<TrascendentalFormNotifier, TrascendentalFormState>(
  (ref) => TrascendentalFormNotifier(
    emotionExternalRepo: TrascendentalRecordsExternalRepositoryImpl(
      TrascendentalRecordsApiDataSource(),
    ),
  ),
);

class TrascendentalFormNotifier extends StateNotifier<TrascendentalFormState> {
  final TrascendentalRecordsExternalRepository _dailyRecordExternalRepo;

  TrascendentalFormNotifier({
    required TrascendentalRecordsExternalRepository emotionExternalRepo,
  })  : _dailyRecordExternalRepo = emotionExternalRepo,
        super(TrascendentalFormState(
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

  void onCompanionChange(String companion) {
    state = state.copyWith(companion: companion);
  }

  void onLocationChange(String location) {
    state = state.copyWith(location: location);
  }

  void onActivityChange(String activity) {
    state = state.copyWith(activity: activity);
  }

  Future<void> onFormSubmit() async {
    try {
      final isCreated = await _dailyRecordExternalRepo.addTrascendentalRecord(
        primaryEmotion: state.primaryEmotionSelected.name,
        secondaryEmotion: state.secondaryEmotionSelected.name,
        location: state.location,
        activity: state.activity,
        companion: state.companion,
      );
      if (isCreated) {
        state = state.copyWith(status: TrascendentalFormStatus.success);
      }
    } on InvalidEmotionSelectedException catch (e) {
      state = state.copyWith(
        status: TrascendentalFormStatus.error,
        errorMessage: e.message,
      );
    } on CantCreateRecordException catch (e) {
      state = state.copyWith(
        status: TrascendentalFormStatus.error,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: TrascendentalFormStatus.error,
        errorMessage: 'Ha ocurrido un error al guardar el registro',
      );
    }
  }

  void _resetState() {
    state = state.copyWith(
      secondaryEmotionSelected: Emotion.empty(),
      description: '',
      status: TrascendentalFormStatus.initial,
      errorMessage: '',
    );
  }
}

enum TrascendentalFormStatus { initial, loading, success, error }

class TrascendentalFormState {
  final Emotion primaryEmotionSelected;
  final Emotion secondaryEmotionSelected;
  final String description;
  final String companion;
  final String location;
  final String activity;
  final TrascendentalFormStatus status;
  final String errorMessage;

  TrascendentalFormState({
    required this.primaryEmotionSelected,
    required this.secondaryEmotionSelected,
    this.description = '',
    this.companion = '',
    this.location = '',
    this.activity = '',
    this.status = TrascendentalFormStatus.initial,
    this.errorMessage = '',
  });

  TrascendentalFormState copyWith({
    Emotion? primaryEmotionSelected,
    Emotion? secondaryEmotionSelected,
    String? description,
    String? companion,
    String? location,
    String? activity,
    TrascendentalFormStatus? status,
    String? errorMessage,
  }) =>
      TrascendentalFormState(
        primaryEmotionSelected:
            primaryEmotionSelected ?? this.primaryEmotionSelected,
        secondaryEmotionSelected:
            secondaryEmotionSelected ?? this.secondaryEmotionSelected,
        description: description ?? this.description,
        companion: companion ?? this.companion,
        location: location ?? this.location,
        activity: activity ?? this.activity,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
