import 'package:emotional_app/shared/domain/validators/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpFormProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>(
  (ref) => SignUpFormNotifier(),
);

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier() : super(SignUpFormState());

  void onNickNameChanged(String nickName) {
    state = state.copyWith(
      nickName: nickName,
      state: SignUpState.validating,
    );
  }

  void onEmailChanged(String email) {
    state = state.copyWith(
      email: email,
      state: SignUpState.validating,
    );
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(
      password: password,
      state: SignUpState.validating,
    );
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      state: SignUpState.validating,
    );
  }

  void onFirstNameChanged(String firstName) {
    state = state.copyWith(
      firstName: firstName,
      state: SignUpState.validating,
    );
  }

  void onLastNameChanged(String lastName) {
    state = state.copyWith(
      lastName: lastName,
      state: SignUpState.validating,
    );
  }

  void onPhoneNumberChanged(String phoneNumber) {
    state = state.copyWith(
      phoneNumber: phoneNumber,
      state: SignUpState.validating,
    );
  }

  void onBirthDateChanged(DateTime birthDate) {
    state = state.copyWith(
      birthDate: birthDate,
      state: SignUpState.validating,
    );
  }

  void onStepChanged(SignUpStep step) {
    state = state.copyWith(currentStep: step);
  }

  bool validateAccountStep() {
    if (Validators.isEmpty(state.nickName) ||
        Validators.isEmpty(state.email) ||
        Validators.isEmpty(state.password) ||
        Validators.isEmpty(state.confirmPassword)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'Por favor, rellene todos los campos para continuar',
      );
      return false;
    }
    if (!Validators.isMinLength(state.nickName, 3)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'El nombre de usuario debe tener al menos 3 caracteres',
      );
      return false;
    }
    if (!Validators.isEmail(state.email)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'Email inválido',
      );
      return false;
    }
    if (!Validators.isSamePassword(state.password, state.confirmPassword)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'Las contraseñas no coinciden',
      );
      return false;
    }
    if (!Validators.isMinLength(state.password, 8)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'La contraseña debe tener al menos 8 caracteres',
      );
      return false;
    }
    return true;
  }

  bool onSummitAccountStep() {
    state = state.copyWith(
      currentStep: SignUpStep.accountStep,
      state: SignUpState.validating,
      errorMessage: '',
    );
    if (validateAccountStep()) {
      state = state.copyWith(
        currentStep: SignUpStep.contactStep,
        state: SignUpState.success,
      );
      return true;
    } else {
      state = state.copyWith(
        state: SignUpState.failure,
      );
      return false;
    }
  }

  bool validateContactStep() {
    state = state.copyWith(
      state: SignUpState.validating,
      errorMessage: '',
    );
    if (Validators.isEmpty(state.firstName) ||
        Validators.isEmpty(state.lastName) ||
        Validators.isEmpty(state.phoneNumber) ||
        state.birthDate == null) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'Por favor, rellene todos los campos para continuar',
      );
      return false;
    }
    if (!Validators.isMinLength(state.firstName, 3)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'El nombre debe tener al menos 3 caracteres',
      );
      return false;
    }
    if (!Validators.isMinLength(state.lastName, 3)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'El apellido debe tener al menos 3 caracteres',
      );
      return false;
    }
    if (!Validators.isMinLength(state.phoneNumber, 10)) {
      state = state.copyWith(
        state: SignUpState.failure,
        errorMessage: 'El número de teléfono debe tener al menos 10 caracteres',
      );
      return false;
    }
    return true;
  }

  void onSummitContactStep() {
    state = state.copyWith(
      currentStep: SignUpStep.contactStep,
      state: SignUpState.validating,
    );
    if (validateContactStep()) {
      state = state.copyWith(
        currentStep: SignUpStep.summitStep,
        state: SignUpState.success,
      );
    } else {
      state = state.copyWith(
        state: SignUpState.failure,
      );
    }
  }

  void cleanState() {
    state = SignUpFormState();
  }
}

enum SignUpStep {
  none,
  accountStep,
  contactStep,
  summitStep,
}

enum SignUpState {
  empty,
  validating,
  failure,
  success,
}

class SignUpFormState {
  final String nickName;
  final String email;
  final String password;
  final String confirmPassword;
  final SignUpStep currentStep;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime? birthDate;
  final SignUpState state;
  final String errorMessage;

  SignUpFormState({
    this.nickName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.currentStep = SignUpStep.none,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.birthDate,
    this.state = SignUpState.empty,
    this.errorMessage = '',
  });
  SignUpFormState copyWith({
    String? nickName,
    String? email,
    String? password,
    String? confirmPassword,
    SignUpStep? currentStep,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? birthDate,
    SignUpState? state,
    String? errorMessage,
  }) =>
      SignUpFormState(
        nickName: nickName ?? this.nickName,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        currentStep: currentStep ?? this.currentStep,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        birthDate: birthDate ?? this.birthDate,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
