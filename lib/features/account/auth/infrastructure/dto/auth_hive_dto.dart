import 'package:hive/hive.dart';

part 'auth_hive_dto.g.dart';

@HiveType(typeId: 0)
class AuthHiveDto extends HiveObject {
  @HiveField(0)
  String accessToken;

  AuthHiveDto({
    required this.accessToken,
  });
}
