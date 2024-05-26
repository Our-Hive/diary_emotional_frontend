import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/infrastructure/dto/auth_api_response.dart';

class TokenApiMapper {
  static Token fromApi(AuthApiResponse data) {
    return Token(
      accessToken: data.token,
    );
  }
}
