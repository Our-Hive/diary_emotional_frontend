import 'package:emotional_app/features/home/domain/entities/Emotion.dart';
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
}

class EmotionsState {
  final Set<Emotion> primaryEmotions;
  final bool isLoading;
  final bool hasError;

  EmotionsState({
    required this.primaryEmotions,
    required this.isLoading,
    required this.hasError,
  });

  factory EmotionsState.initial() {
    return EmotionsState(
      primaryEmotions: {},
      isLoading: false,
      hasError: false,
    );
  }

  EmotionsState copyWith({
    Set<Emotion>? primaryEmotions,
    bool? isLoading,
    bool? hasError,
  }) {
    return EmotionsState(
      primaryEmotions: primaryEmotions ?? this.primaryEmotions,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
