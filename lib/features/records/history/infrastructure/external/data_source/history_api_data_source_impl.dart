import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/records/history/domain/external/data_source/history_external_data_source.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/dto/get_record_history_response_dto.dart';
import 'package:emotional_app/features/records/history/infrastructure/external/mappers/record_history_mapper.dart';
import 'package:emotional_app/features/records/record/domain/entities/record.dart';

class HistoryApiDataSourceImpl implements HistoryExternalDataSource {
  @override
  Future<List<Record>> getHistory({int page = 0}) async {
    try {
      final response = await AppHttpSingleton().get(
        '/emotional-records',
        params: {
          'page': page,
        },
      );
      final List<GetRecordHistoryResponseDto> dto = (response.data as List)
          .map((e) => GetRecordHistoryResponseDto.fromJson(e))
          .toList();
      return RecordHistoryMapper.fromGetRecordHistoryResponseDto(dto);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
