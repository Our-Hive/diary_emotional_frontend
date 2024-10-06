import 'dart:developer';

import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/account/user/domain/data_source/user_data_source.dart';
import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/infrastructure/dto/api_user.dart';
import 'package:emotional_app/features/account/user/infrastructure/mapper/user_api_mapper.dart';

class UserApiDataSourceImpl implements UserDataSource {
  final mapper = UserApiMapper();

  @override
  Future<User> getUser() async {
    final response = await AppHttpSingleton().get(
      '/users',
    );
    final apiUser = UserApiResponseDto.fromJson(response.data);
    return mapper.fromApi(apiUser);
  }

  @override
  Future<bool> disableUser(String password) async {
    try {
      final response = await AppHttpSingleton().delete(
        '/users',
        data: {
          'password': password,
        },
      );
      if (response.statusCode != 204) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateUser({
    String? userName,
    String? phone,
    DateTime? birthDate,
  }) async {
    try {
      final body = {
        if (userName != null && userName.isNotEmpty) 'username': userName,
        if (phone != null && phone.isNotEmpty) 'mobileNumber': phone,
        if (birthDate != null) 'birthdate': birthDate.toIso8601String(),
      };
      if (body.isEmpty) {
        return false;
      }
      final response = await AppHttpSingleton().patch('/users', data: body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
