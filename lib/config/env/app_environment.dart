import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? "Unconfigured Environment";
}
