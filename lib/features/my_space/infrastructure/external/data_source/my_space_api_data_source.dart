import 'package:emotional_app/config/http/go_http_singleton.dart';
import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';
import 'package:emotional_app/features/my_space/domain/external/data_source/my_space_external_data_source.dart';

class MySpaceApiDataSourceImpl implements MySpaceExternalDataSource {
  @override
  Future<List<MySpace>> getMySpace() async {
    try {
      final response = await GoHttpSingleton().get(
        '/images/approval',
        params: {
          'approved': true,
        },
      );
      if (response.statusCode == 200) {}
      // todo: implementar
      throw UnimplementedError();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
