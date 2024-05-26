import 'package:hive_flutter/hive_flutter.dart';
import 'package:emotional_app/features/account/auth/infrastructure/dto/auth_hive_dto.dart';

class HiveSetUp {
  static String authBox = 'auth_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    registerHiveAdapters();
    await openBoxes();
  }

  static void registerHiveAdapters() async {
    Hive.registerAdapter(AuthHiveDtoAdapter());
  }

  static Future<void> openBoxes() async {
    await Hive.openBox<AuthHiveDto>(authBox);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
