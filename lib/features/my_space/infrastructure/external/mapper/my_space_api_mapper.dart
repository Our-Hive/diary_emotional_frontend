import 'package:emotional_app/features/my_space/domain/entities/my_space.dart';
import 'package:emotional_app/features/my_space/infrastructure/external/dtos/get_my_space_approved_response_dto.dart';

class MySpaceApiMapper {
  static List<MySpace> fromGetMySpaceApprovedResponseDto(
      List<GetMySpaceApprovedResponseDto> dto) {
    return dto.map((e) {
      final type = e.contentType.contains('image')
          ? MySpaceType.image
          : MySpaceType.video;
      return MySpace(
        id: e.id,
        name: e.name,
        url: e.url,
        type: type,
        createdAt: e.createdTime,
      );
    }).toList();
  }
}
