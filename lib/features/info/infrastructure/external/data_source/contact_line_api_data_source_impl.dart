import 'package:emotional_app/config/http/go_http_singleton.dart';
import 'package:emotional_app/features/info/domain/entities/contact_line.dart';
import 'package:emotional_app/features/info/domain/external/data_source/contact_line_external_data_source.dart';

class ContactLineApiDataSourceImpl implements ContactLineExternalDataSource {
  @override
  Future<List<ContactLine>> getContactLine() async {
    final res = await GoHttpSingleton().get('/contact-line');

    // todo: mapping and response
    throw UnimplementedError();
  }
}
