import 'package:emotional_app/features/account/user/domain/repository/user_repository.dart';
import 'package:emotional_app/features/account/user/infrastructure/data_source/user_api_data_source_impl.dart';
import 'package:emotional_app/features/account/user/infrastructure/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editUserFormProvider =
    StateNotifierProvider<EditUserFormNotifier, EditUserFormState>(
  (ref) => EditUserFormNotifier(
      userRepository: UserRepositoryImpl(
    UserApiDataSourceImpl(),
  )),
);

class EditUserFormNotifier extends StateNotifier<EditUserFormState> {
  final UserRepository _userRepository;

  EditUserFormNotifier({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(EditUserFormState());

  void onUserNameChange(String newUserName) {
    state = state.copyWith(userName: newUserName);
  }

  void onPhoneChange(String newPhone) {
    state = state.copyWith(phone: newPhone);
  }

  void onBirthDateChange(DateTime newBirthDate) {
    state = state.copyWith(birthDate: newBirthDate);
  }

  Future<void> onSubmit() async {
    final isEdited = await _userRepository.updateUser(
      userName: state.userName,
      phone: state.phone,
      birthDate: state.birthDate,
    );
    isEdited
        ? state = state.copyWith(isSuccess: true)
        : state = state.copyWith(isFailure: true);
  }
}

class EditUserFormState {
  final String userName;
  final String phone;
  final DateTime? birthDate;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  EditUserFormState({
    this.userName = '',
    this.phone = '',
    this.birthDate,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  EditUserFormState copyWith({
    String? userName,
    String? phone,
    DateTime? birthDate,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) =>
      EditUserFormState(
        userName: userName ?? this.userName,
        phone: phone ?? this.phone,
        birthDate: birthDate ?? this.birthDate,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
      );
}
