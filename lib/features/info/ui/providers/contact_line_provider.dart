import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emotional_app/features/info/domain/entities/contact_line.dart';
import 'package:emotional_app/features/info/domain/external/repository/contact_line_external_repository.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/contact_line_api_data_source_impl.dart';
import 'package:emotional_app/features/info/infrastructure/external/repository/contact_line_external_repository_impl.dart';

final contactLineProvider =
    StateNotifierProvider<ContactLineNotifier, ContactLineState>(
  (ref) => ContactLineNotifier(
    ContactLineState(),
    contactLineExternalRepo: ContactLineExternalRepositoryImpl(
      ContactLineApiDataSourceImpl(),
    ),
  ),
);

class ContactLineNotifier extends StateNotifier<ContactLineState> {
  final ContactLineExternalRepository _contactLineExternalRepo;
  ContactLineNotifier(
    super._state, {
    required contactLineExternalRepo,
  }) : _contactLineExternalRepo = contactLineExternalRepo;

  Future<void> getContactLines() async {
    try {
      final contactLines = await _contactLineExternalRepo.getContactLine();
      state = state.copyWith(contactLines: contactLines);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class ContactLineState {
  final List<ContactLine> contactLines;
  final bool isLoading;
  final String error;

  ContactLineState({
    this.contactLines = const [],
    this.isLoading = false,
    this.error = '',
  });

  ContactLineState copyWith({
    List<ContactLine>? contactLines,
    bool? isLoading,
    String? error,
  }) {
    return ContactLineState(
      contactLines: contactLines ?? this.contactLines,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
