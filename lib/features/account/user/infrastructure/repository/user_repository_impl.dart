import 'package:emotional_app/features/account/user/domain/data_source/user_data_source.dart';
import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  UserRepositoryImpl(this._userDataSource);

  @override
  Future<User> getUser() {
    return _userDataSource.getUser();
  }

  @override
  Future<bool> disableUser(String password) {
    return _userDataSource.disableUser(password);
  }

  @override
  Future<bool> updateUser({
    String? userName,
    String? phone,
    DateTime? birthDate,
  }) {
    return _userDataSource.updateUser(
      userName: userName,
      phone: phone,
      birthDate: birthDate,
    );
  }
}
