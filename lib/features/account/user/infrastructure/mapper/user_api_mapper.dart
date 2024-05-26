import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/infrastructure/dto/api_user.dart';

class UserApiMapper {
  User fromApi(UserApiResponseDto apiUser) {
    return User(
      firstName: apiUser.firstName,
      lastName: apiUser.lastName,
      userName: apiUser.username,
      email: apiUser.email,
      phoneNumber: apiUser.mobileNumber,
      birthDate: apiUser.birthDate,
    );
  }
}
