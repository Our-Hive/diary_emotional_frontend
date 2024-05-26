import 'package:emotional_app/features/account/auth/domain/local/auth_local_data_source.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/infrastructure/dto/auth_hive_dto.dart';
import 'package:emotional_app/config/db/hive/hive_setup.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<AuthHiveDto> _authBox = Hive.box<AuthHiveDto>(HiveSetUp.authBox);

  @override
  Future<bool> saveAuthToken(Token token) async {
    try {
      if (_authBox.values.isEmpty) {
        await _authBox.add(AuthHiveDto(accessToken: token.accessToken));
        return true;
      } else {
        await _authBox.putAt(0, AuthHiveDto(accessToken: token.accessToken));
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Token? getAuthToken() {
    if (_authBox.values.isNotEmpty) {
      return Token(
        accessToken: _authBox.getAt(0)!.accessToken,
      );
    }
    return null;
  }

  @override
  Future<bool> deleteAuthToken() async {
    if (_authBox.values.isNotEmpty) {
      await _authBox.deleteAt(0);
      return true;
    }
    return false;
  }
}
