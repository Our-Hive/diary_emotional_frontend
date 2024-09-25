import 'package:emotional_app/features/my_space/domain/external/repository/my_space_external_repository.dart';
import 'package:emotional_app/features/my_space/infrastructure/external/data_source/my_space_api_data_source.dart';
import 'package:emotional_app/features/my_space/infrastructure/external/repository/my_space_external_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';

final mySpaceProvider = StateNotifierProvider<MySpaceNotifier, MySpaceState>(
  (ref) => MySpaceNotifier(
    MySpaceState(),
    mySpaceExternalRepository: MySpaceExternalRepositoryImpl(
      MySpaceApiDataSourceImpl(),
    ),
  ),
);

class MySpaceNotifier extends StateNotifier<MySpaceState> {
  final MySpaceExternalRepository _externalRepository;

  MySpaceNotifier(
    super.state, {
    required mySpaceExternalRepository,
  }) : _externalRepository = mySpaceExternalRepository;

  Future<void> getMySpaces() async {
    try {
      final spaces = await _externalRepository.getMySpace();
      state = state.copyWith(spaces: spaces);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class MySpaceState {
  final List<MySpace> spaces;
  final bool isLoading;
  final String error;

  MySpaceState({
    this.spaces = const [],
    this.isLoading = false,
    this.error = '',
  });

  MySpaceState copyWith({
    List<MySpace>? spaces,
    bool? isLoading,
    String? error,
  }) {
    return MySpaceState(
      spaces: spaces ?? this.spaces,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
