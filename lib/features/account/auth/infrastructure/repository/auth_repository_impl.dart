import 'package:emotional_app/features/account/auth/domain/external/auth_external_data_source.dart';
import 'package:emotional_app/features/account/auth/domain/entities/login_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/sign_up_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/domain/external/auth_external_repository.dart';

class AuthExternalRepositoryImpl implements AuthExternalRepository {
  final AuthExternalDataSource _dataSource;

  AuthExternalRepositoryImpl(this._dataSource);

  @override
  Future<Token> login(LoginCredentials authCredentials) async {
    return await _dataSource.login(authCredentials);
  }

  @override
  Future<Token> signUp(SignUpCredentials signUpCredentials) async {
    return await _dataSource.signUp(signUpCredentials);
  }
}
