import 'package:emotional_app/features/info/domain/entities/contact_line.dart';

abstract class ContactLineExternalDataSource {
  Future<List<ContactLine>> getContactLine();
}
