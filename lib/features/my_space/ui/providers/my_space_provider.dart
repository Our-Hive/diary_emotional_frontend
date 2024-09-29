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
      await Future.delayed(Duration(seconds: 2));
      /*  final spaces = [
        MySpace(
          id: "id",
          name: "Nine Sols",
          type: MySpaceType.image,
          url:
              "https://external-preview.redd.it/nine-sols-is-out-now-for-backers-and-releases-tomorrow-v0-oXC3r33Q-vcQy3f8KH23xaCu9ZkVPKmUyqNr553hD6s.jpg?width=640&crop=smart&auto=webp&s=20594e6a2c82eb17abd189e86dc0c01c1c0284c9",
          createdAt: DateTime.now(),
        ),
        MySpace(
          id: "id",
          name: "Hollow Knight: Silksong",
          type: MySpaceType.image,
          url:
              "https://images.squarespace-cdn.com/content/v1/606d4bb793879d12d807d4c8/1619984695272-X5ZWEPXBSOXKPT26QCT7/Silksong_Promo_02small.jpg",
          createdAt: DateTime.now(),
        ),
        MySpace(
          id: "id",
          name: "Bee",
          type: MySpaceType.video,
          url:
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          createdAt: DateTime.now(),
        )
      ]; */
      final spaces = await _externalRepository.getMySpace();
      state = state.copyWith(spaces: spaces);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadNextPage() async {
    state = state.copyWith(isLoading: true);
    try {
      final spaces = await _externalRepository.getMySpace();
      state = state.copyWith(spaces: [...state.spaces, ...spaces]);
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
