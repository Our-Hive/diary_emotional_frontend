import 'package:emotional_app/features/support_network/domain/entities/support_network_member.dart';
import 'package:emotional_app/features/support_network/domain/repository/support_network_external_repository.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/data_source/support_network_api_data_source_impl.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/repository/support_network_external_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supportNetworkProvider =
    StateNotifierProvider<SupportNetworkNotifier, SupportNetworkState>(
  (ref) => SupportNetworkNotifier(
    supportNetworkExternalRepository: SupportNetworkExternalRepositoryImpl(
      SupportNetworkApiDataSourceImpl(),
    ),
  ),
);

class SupportNetworkNotifier extends StateNotifier<SupportNetworkState> {
  final SupportNetworkExternalRepository _supportNetworkExternalRepository;

  SupportNetworkNotifier({
    required SupportNetworkExternalRepository supportNetworkExternalRepository,
  })  : _supportNetworkExternalRepository = supportNetworkExternalRepository,
        super(
          SupportNetworkState(),
        );

  getSupportNetwork() async {
    try {
      final supportMembers =
          await _supportNetworkExternalRepository.getSupportNetwork();
      state = state.copyWith(
        supportMembers: supportMembers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

class SupportNetworkState {
  final List<SupportNetworkMember> supportMembers;
  final bool isLoading;
  final String errorMessage;

  SupportNetworkState({
    this.supportMembers = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  SupportNetworkState copyWith({
    List<SupportNetworkMember>? supportMembers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SupportNetworkState(
      supportMembers: supportMembers ?? this.supportMembers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
