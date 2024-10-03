import 'package:flutter_riverpod/flutter_riverpod.dart';

final disableFormProvider =
    StateNotifierProvider<DisableFormNotifier, DisableFormState>(
  (ref) => DisableFormNotifier(),
);

class DisableFormNotifier extends StateNotifier<DisableFormState> {
  DisableFormNotifier() : super(DisableFormState());

  void onSecurityPasswordChanged(String securityPassword) {
    state = state.copyWith(securityPassword: securityPassword);
  }

  bool onSubmit() {
    state = state.copyWith(isSubmitting: true);
    if (state.securityPassword.isNotEmpty) {
      state = state.copyWith(
        isSuccess: true,
        isSubmitting: false,
      );
      return true;
    }
    state = state.copyWith(
      isFailure: true,
      isSubmitting: false,
    );
    return false;
  }
}

class DisableFormState {
  final String securityPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  DisableFormState({
    this.securityPassword = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  DisableFormState copyWith({
    String? securityPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) =>
      DisableFormState(
        securityPassword: securityPassword ?? this.securityPassword,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
      );
}
