import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/domain/repository/user_repository.dart';
import 'package:emotional_app/features/account/user/infrastructure/data_source/user_api_data_source_impl.dart';
import 'package:emotional_app/features/account/user/infrastructure/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(
    userRepository: UserRepositoryImpl(UserApiDataSourceImpl()),
  ),
);

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _userRepository;
  UserNotifier({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          UserState(
            currentUser: User.empty(),
          ),
        );

  Future<void> getUser() async {
    try {
      final user = await _userRepository.getUser();
      state = state.copyWith(
        currentUser: user,
        status: UserStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> disableUser(String password) async {
    final bool isDeleted = await _userRepository.disableUser(password);
    if (isDeleted) {
      state = state.copyWith(status: UserStatus.disabled);
      return;
    }
    state = state.copyWith(
      status: UserStatus.error,
      errorMessage: 'el usuario no fue eliminado, intenta de nuevo',
    );
  }
}

enum UserStatus { empty, editing, loading, error, success, disabled }

class UserState {
  final User currentUser;
  final UserStatus status;
  final String errorMessage;

  UserState({
    required this.currentUser,
    this.status = UserStatus.empty,
    this.errorMessage = '',
  });

  UserState copyWith({
    User? currentUser,
    UserStatus? status,
    String? errorMessage,
  }) {
    return UserState(
      currentUser: currentUser ?? this.currentUser,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
