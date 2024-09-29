import 'package:emotional_app/config/http/go_http_singleton.dart';
import 'package:emotional_app/features/info/domain/entities/contact_line.dart';
import 'package:emotional_app/features/info/domain/external/data_source/contact_line_external_data_source.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/dtos/get_contact_lines_response_dto.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/mappers/contact_lines_api_mapper.dart';

class ContactLineApiDataSourceImpl implements ContactLineExternalDataSource {
  @override
  Future<List<ContactLine>> getContactLine() async {
    try {
      final res = await GoHttpSingleton().get('/contact-lines');
      final List<GetContactLinesResponseDto> dto = (res.data as List).map(
        (e) => GetContactLinesResponseDto.fromJson(e),
      ).toList();
      return ContactLinesApiMapper.fromGetGetContactLinesResponseDto(dto);
    } catch (e) {
      throw Exception(e);
    }
  }
}
