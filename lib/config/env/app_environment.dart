import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? "Unconfigured Environment";
  static String goApiUrl =
      dotenv.env['GO_API_URL'] ?? "Unconfigured Environment";
}
