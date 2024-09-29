import 'package:emotional_app/features/info/domain/entities/contact_line.dart';
import 'package:emotional_app/features/info/infrastructure/external/data_source/dtos/get_contact_lines_response_dto.dart';

class ContactLinesApiMapper {
  static List<ContactLine> fromGetGetContactLinesResponseDto(
      List<GetContactLinesResponseDto> dto) {
    return dto
        .map(
          (e) => ContactLine(
            title: e.name,
            description: e.description,
          ),
        )
        .toList();
  }
}
