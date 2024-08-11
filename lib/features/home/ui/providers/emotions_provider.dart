import 'package:emotional_app/features/home/domain/entities/emotion.dart';
import 'package:emotional_app/features/home/domain/external/repository/emotion_external_repository.dart';
import 'package:emotional_app/features/home/infrastructure/external/api/emotion_api_data_source.dart';
import 'package:emotional_app/features/home/infrastructure/external/repository/emotion_external_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emotionsProvider = StateNotifierProvider<EmotionsNotifier, EmotionsState>(
  (ref) => EmotionsNotifier(
    emotionExternalRepo: EmotionExternalRepositoryImpl(EmotionApiDataSource()),
  ),
);

class EmotionsNotifier extends StateNotifier<EmotionsState> {
  final EmotionExternalRepository _emotionExternalRepo;
  EmotionsNotifier({
    required EmotionExternalRepository emotionExternalRepo,
  })  : _emotionExternalRepo = emotionExternalRepo,
        super(
          EmotionsState.initial(),
        );

  Future<void> getPrimaryEmotions() async {
    try {
      final primaryEmotions = await _emotionExternalRepo.getPrimaryEmotions();
      state = state.copyWith(
        primaryEmotions: primaryEmotions,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
      );
    }
  }

  Future<void> getSecondaryEmotions(String emotion) async {
    try {
      final secondaryEmotions =
          await _emotionExternalRepo.getSecondaryEmotions(emotion);
      state = state.copyWith(
        secondaryEmotions: secondaryEmotions,
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
      );
    }
  }
}

class EmotionsState {
  final Set<Emotion> primaryEmotions;
  final List<Emotion> secondaryEmotions;
  final bool isLoading;
  final bool hasError;

  EmotionsState({
    required this.primaryEmotions,
    required this.secondaryEmotions,
    required this.isLoading,
    required this.hasError,
  });

  factory EmotionsState.initial() {
    return EmotionsState(
      primaryEmotions: {},
      secondaryEmotions: [],
      isLoading: false,
      hasError: false,
    );
  }

  EmotionsState copyWith({
    Set<Emotion>? primaryEmotions,
    List<Emotion>? secondaryEmotions,
    bool? isLoading,
    bool? hasError,
  }) {
    return EmotionsState(
      primaryEmotions: primaryEmotions ?? this.primaryEmotions,
      secondaryEmotions: secondaryEmotions ?? this.secondaryEmotions,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
