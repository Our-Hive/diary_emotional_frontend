import 'package:emotional_app/features/info/infrastructure/external/data_source/recommended_content_api_data_source_impl.dart';
import 'package:emotional_app/features/info/infrastructure/external/repository/recommended_content_external_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/info/domain/entities/recommended_content.dart';
import 'package:emotional_app/features/info/domain/external/repository/recommended_content_external_repository.dart';

final recommendedContentProvider =
    StateNotifierProvider<RecommendedContentNotifier, RecommendedContentState>(
  (ref) => RecommendedContentNotifier(
    RecommendedContentState(),
    contactLineExternalRepo: RecommendedContentExternalRepositoryImpl(
      RecommendedContentApiDataSourceImpl(),
    ),
  ),
);

class RecommendedContentNotifier
    extends StateNotifier<RecommendedContentState> {
  final RecommendedContentExternalRepository _contactLineExternalRepo;
  RecommendedContentNotifier(
    super._state, {
    required contactLineExternalRepo,
  }) : _contactLineExternalRepo = contactLineExternalRepo;

  void getRecommendedContent() async {
    try {
      final recommendedList =
          await _contactLineExternalRepo.getRecommendedContent();
      state = state.copyWith(recommendedContentList: recommendedList);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class RecommendedContentState {
  final List<RecommendedContent> recommendedContentList;
  final bool isLoading;
  final String error;

  RecommendedContentState({
    this.recommendedContentList = const [],
    this.isLoading = false,
    this.error = '',
  });

  RecommendedContentState copyWith({
    List<RecommendedContent>? recommendedContentList,
    bool? isLoading,
    String? error,
  }) {
    return RecommendedContentState(
      recommendedContentList:
          recommendedContentList ?? this.recommendedContentList,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
