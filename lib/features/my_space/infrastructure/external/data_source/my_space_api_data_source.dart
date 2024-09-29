import 'package:emotional_app/config/http/go_http_singleton.dart';
import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';
import 'package:emotional_app/features/my_space/domain/external/data_source/my_space_external_data_source.dart';
import 'package:emotional_app/features/my_space/infrastructure/external/dtos/get_my_space_approved_response_dto.dart';
import 'package:emotional_app/features/my_space/infrastructure/external/mapper/my_space_api_mapper.dart';

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
      if (response.statusCode == 200) {
        final List<GetMySpaceApprovedResponseDto> dto = (response.data as List)
            .map((e) => GetMySpaceApprovedResponseDto.fromJson(e))
            .toList();
        return MySpaceApiMapper.fromGetMySpaceApprovedResponseDto(dto);
      }
      throw Exception();
    } catch (e) {
      throw Exception(e);
    }
  }
}
