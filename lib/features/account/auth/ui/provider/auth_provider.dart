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

  AuthNotifier(
      {required AuthExternalRepository authApiRepo,
      required AuthLocalRepository authLocalRepo})
      : _authApiRepo = authApiRepo,
        _authLocalRepo = authLocalRepo,
        super(AuthState.initial());

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
        isLoading: false,
        isAuth: true,
        token: token,
      );
    } on InvalidCredentialsException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } on HttpException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
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
        isLoading: false,
        isAuth: true,
        token: token,
      );
    } on InvalidCredentialsException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } on HttpException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class AuthState {
  final bool isLoading;
  final bool isAuth;
  final Token? token;
  final String error;

  AuthState({
    required this.isLoading,
    required this.isAuth,
    this.token,
    this.error = '',
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      isAuth: false,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isAuth,
    Token? token,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuth: isAuth ?? this.isAuth,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }
}
