import 'package:emotional_app/features/info/domain/entities/contact_line.dart';

abstract class ContactLineExternalRepository {
  Future<List<ContactLine>> getContactLine();
}
