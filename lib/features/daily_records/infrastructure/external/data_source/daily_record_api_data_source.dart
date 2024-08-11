import 'package:dio/dio.dart';
import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/daily_records/domain/external/data_source/daily_record_external_data_source.dart';
import 'package:emotional_app/features/daily_records/infrastructure/external/exceptions/cant_create_record_exception.dart';
import 'package:emotional_app/features/daily_records/infrastructure/external/exceptions/invalid_emotion_selected_exception.dart';

class DailyRecordApiDataSource implements DailyRecordExternalDataSource {
  DailyRecordApiDataSource();

  @override
  Future<bool> addDailyRecord({
    required String primaryEmotion,
    required String secondaryEmotion,
    required String description,
  }) async {
    try {
      final response = await AppHttpSingleton().post(
        '/emotional-records/daily',
        data: {
          'primaryEmotion': primaryEmotion,
          'secondaryEmotion': secondaryEmotion,
          'description': description,
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw InvalidEmotionSelectedException();
      }
      if (e.response?.statusCode == 400) {
        throw CantCreateRecordException();
      }
    } catch (e) {
      throw Exception();
    }
    return false;
  }
}
