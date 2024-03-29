import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/ui/provider/auth_provider.dart';
import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/domain/repository/user_repository.dart';
import 'package:emotional_app/features/account/user/infrastructure/data_source/api_user_data_source_impl.dart';
import 'package:emotional_app/features/account/user/infrastructure/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(
    userRepository: UserRepositoryImpl(ApiUserDataSourceImpl()),
    token: ref.watch(authProvider).token ?? Token(accessToken: ''),
  ),
);

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _userRepository;
  final Token _token;
  UserNotifier({
    required UserRepository userRepository,
    required Token token,
  })  : _userRepository = userRepository,
        _token = token,
        super(
          UserState(
            currentUser: User.empty(),
          ),
        );

  Future<void> getUser() async {
    try {
      final user = await _userRepository.getUser(_token);
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
    final bool isDeleted = await _userRepository.disableUser(_token, password);
    if (isDeleted) {
      state = state.copyWith(status: UserStatus.disabled);
      return;
    }
    state = state.copyWith(
      status: UserStatus.error,
      errorMessage: 'el usuario no fue eliminado',
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
