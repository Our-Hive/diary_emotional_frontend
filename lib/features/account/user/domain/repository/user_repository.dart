import 'package:emotional_app/features/account/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
  Future<User> updateUser(User user);
  Future<bool> disableUser(String password);
}
