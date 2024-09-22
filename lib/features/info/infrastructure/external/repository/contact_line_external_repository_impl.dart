import 'package:emotional_app/features/info/domain/entities/contact_line.dart';
import 'package:emotional_app/features/info/domain/external/data_source/contact_line_external_data_source.dart';
import 'package:emotional_app/features/info/domain/external/repository/contact_line_external_repository.dart';

class ContactLineExternalRepositoryImpl
    implements ContactLineExternalRepository {
  final ContactLineExternalDataSource _dataSource;
  ContactLineExternalRepositoryImpl(this._dataSource);

  @override
  Future<List<ContactLine>> getContactLine() {
    return _dataSource.getContactLine();
  }
}
