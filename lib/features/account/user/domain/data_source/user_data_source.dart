import 'package:emotional_app/features/account/user/domain/entities/user.dart';

abstract class UserDataSource {
  Future<User> getUser();
  Future<User> updateUser(User user);
  Future<bool> disableUser(String password);
}
