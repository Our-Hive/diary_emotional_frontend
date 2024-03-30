import 'package:emotional_app/shared/domain/validators/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>(
  (ref) => LoginFormNotifier(),
);

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  bool onSubmit() {
    state = state.copyWith(
      isFailure: false,
      isSubmitting: true,
    );
    if (validateCredentials()) {
      state = state.copyWith(
        isSuccess: true,
        isSubmitting: false,
      );
      return true;
    } else {
      state = state.copyWith(
        isFailure: true,
        isSubmitting: false,
      );
      return false;
    }
  }

  bool validateCredentials() {
    state = state.copyWith(
      isFailure: false,
      errorMessage: '',
    );
    if (Validators.isEmpty(state.email) || Validators.isEmpty(state.password)) {
      state = state.copyWith(
        isFailure: true,
        errorMessage: 'Por favor, rellene todos los campos para continuar',
      );
      return false;
    }
    if (!Validators.isEmail(state.email)) {
      state = state.copyWith(
        isFailure: true,
        errorMessage: 'Email inválido',
      );
      return false;
    }
    if (!Validators.isMinLength(state.password, 8)) {
      state = state.copyWith(
        isFailure: true,
        errorMessage: 'La contraseña debe tener al menos 8 caracteres',
      );
      return false;
    }
    return true;
  }
}

class LoginFormState {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  LoginFormState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage = '',
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
  }) =>
      LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
