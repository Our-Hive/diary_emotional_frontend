import 'package:emotional_app/config/db/hive/hive_setup.dart';
import 'package:hive/hive.dart';
import 'package:emotional_app/features/account/auth/infrastructure/dto/auth_hive_dto.dart';

class Boxes {
  static Box<AuthHiveDto> authBox() => Hive.box<AuthHiveDto>(HiveSetUp.authBox);
}
