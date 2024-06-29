import 'package:emotional_app/features/account/auth/domain/entities/login_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/sign_up_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/domain/local/auth_local_repository.dart';
import 'package:emotional_app/features/account/auth/domain/external/auth_external_repository.dart';
import 'package:emotional_app/features/account/auth/infrastructure/data_source/auth_api_data_source_impl.dart';
import 'package:emotional_app/features/account/auth/infrastructure/data_source/auth_local_data_source_impl.dart';
import 'package:emotional_app/features/account/auth/infrastructure/exceptions/invalid_credentials.dart';
import 'package:emotional_app/features/account/auth/infrastructure/repository/auth_local_repository_impl.dart';
import 'package:emotional_app/features/account/auth/infrastructure/repository/auth_repository_impl.dart';
import 'package:emotional_app/shared/infrastructure/exceptions/http_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    authApiRepo: AuthExternalRepositoryImpl(
      AuthApiDataSourceImpl(),
    ),
    authLocalRepo: AuthLocalRepositoryImpl(
      AuthLocalDataSourceImpl(),
    ),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthExternalRepository _authApiRepo;
  final AuthLocalRepository _authLocalRepo;

  AuthNotifier({
    required AuthExternalRepository authApiRepo,
    required AuthLocalRepository authLocalRepo,
  })  : _authApiRepo = authApiRepo,
        _authLocalRepo = authLocalRepo,
        super(AuthState.initial()) {
    hasToken();
  }
  void hasToken() {
    try {
      final Token? token = _authLocalRepo.getAuthToken();
      if (token != null && token.accessToken.isNotEmpty) {
        state = state.copyWith(
          authStatus: AuthStatus.authenticated,
          token: token,
        );
      } else {
        state = state.copyWith(
          authStatus: AuthStatus.unAuthenticated,
        );
      }
    } catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unAuthenticated,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final token = await _authApiRepo.login(
        LoginCredentials(
          email: email,
          password: password,
        ),
      );
      final isSaved = await _authLocalRepo.saveAuthToken(token);
      if (!isSaved) {
        throw Exception('Error saving token.');
      }
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        token: token,
      );
    } on InvalidCredentialsException catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unAuthenticated,
        error: e.message,
      );
    } on HttpException catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.error,
        error: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> signUp(SignUpCredentials signUpCredentials) async {
    try {
      final token = await _authApiRepo.signUp(signUpCredentials);
      final isSaved = await _authLocalRepo.saveAuthToken(token);
      if (!isSaved) {
        throw Exception('Error saving token.');
      }
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        token: token,
      );
    } on InvalidCredentialsException catch (e) {
      state = state.copyWith(
        authStatus: AuthStatus.unAuthenticated,
        error: e.message,
      );
    } on HttpException catch (e) {
      state = state.copyWith(authStatus: AuthStatus.error, error: e.message);
    } catch (e) {
      state = state.copyWith(authStatus: AuthStatus.error, error: e.toString());
    }
  }
}

enum AuthStatus { authenticated, unAuthenticated, verifying, error }

class AuthState {
  final Token? token;
  final AuthStatus authStatus;
  final String error;

  AuthState({
    this.authStatus = AuthStatus.verifying,
    this.token,
    this.error = '',
  });

  factory AuthState.initial() {
    return AuthState(
      authStatus: AuthStatus.verifying,
    );
  }

  AuthState copyWith({
    AuthStatus? authStatus,
    Token? token,
    String? error,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }
}
