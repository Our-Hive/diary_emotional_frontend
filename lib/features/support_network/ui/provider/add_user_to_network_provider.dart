import 'package:emotional_app/features/support_network/infrastructure/api/data_source/support_network_api_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/support_network/domain/repository/support_network_external_repository.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/exceptions/user_already_in_network_exception.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/exceptions/user_cannot_support_himself_exception.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/exceptions/user_not_found_exception.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/repository/support_network_external_repository_impl.dart';

final addUserToNetworkProvider =
    StateNotifierProvider<AddUserToNetworkNotifier, AddUserToNetworkState>(
  (ref) => AddUserToNetworkNotifier(
    supportNetworkExternalRepository: SupportNetworkExternalRepositoryImpl(
      SupportNetworkApiDataSourceImpl(),
    ),
  ),
);

class AddUserToNetworkNotifier extends StateNotifier<AddUserToNetworkState> {
  final SupportNetworkExternalRepository _supportNetworkExternalRepository;

  AddUserToNetworkNotifier({
    required SupportNetworkExternalRepository supportNetworkExternalRepository,
  })  : _supportNetworkExternalRepository = supportNetworkExternalRepository,
        super(AddUserToNetworkState());

  void onUsernameChanged(String newUserName) {
    state = state.copyWith(userName: newUserName);
  }

  Future<void> onSubmit() async {
    try {
      state = state.copyWith(isSubmitting: true);
      final isSuccess =
          await _supportNetworkExternalRepository.addSupportNetworkByUserName(
        state.userName,
      );

      state = state.copyWith(
        isSubmitting: false,
        isSuccess: isSuccess,
      );
    } on UserNotFoundException {
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: 'Usuario no encontrado',
      );
    } on UserCannotSupportHimselfException {
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: 'No puedes agregarte a ti mismo',
      );
    } on UserAlreadyInNetworkException {
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: 'El usuario ya está en tu red de apoyo',
      );
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
    resetState();
  }

  void resetState() {
    state = state.copyWith(
      userName: '',
      isSubmitting: false,
      isSuccess: false,
      errorMessage: '',
    );
  }
}

class AddUserToNetworkState {
  final String userName;
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;

  AddUserToNetworkState({
    this.userName = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  AddUserToNetworkState copyWith({
    String? userName,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) =>
      AddUserToNetworkState(
        userName: userName ?? this.userName,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
