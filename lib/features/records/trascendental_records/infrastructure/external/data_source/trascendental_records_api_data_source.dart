import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/entities/trascendental_record.dart';
import 'package:emotional_app/features/records/trascendental_records/domain/external/data_source/trascendental_records_external_data_source.dart';

class TrascendentalRecordsApiDataSource
    implements TrascendentalRecordsExternalDataSource {
  @override
  Future<bool> addTrascendentalRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String location,
    required String activity,
    required String companion,
  }) async {
    try {
      final response = await AppHttpSingleton().post(
        '/emotional-records/transcendental',
        data: {
          'primaryEmotion': primaryEmotion,
          'secondaryEmotion': secondaryEmotion,
          'location': location,
          'activity': activity,
          'companion': companion,
          'date': DateTime.now().toIso8601String(),
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<TrascendentalRecord>> getTrascendentalRecords() async {
    throw UnimplementedError();
  }
}
