import 'package:emotional_app/features/account/auth/domain/local/auth_local_data_source.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/domain/local/auth_local_repository.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepositoryImpl(this._authLocalDataSource);

  @override
  Future<bool> saveAuthToken(Token token) {
    return _authLocalDataSource.saveAuthToken(token);
  }

  @override
  Token? getAuthToken() {
    return _authLocalDataSource.getAuthToken();
  }

  @override
  Future<bool> deleteAuthToken() {
    return _authLocalDataSource.deleteAuthToken();
  }
}
