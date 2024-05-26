import 'package:emotional_app/features/account/auth/domain/entities/login_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/sign_up_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';

abstract class AuthExternalDataSource {
  Future<Token> login(LoginCredentials authCredentials);
  Future<Token> signUp(SignUpCredentials signUpCredentials);
}
