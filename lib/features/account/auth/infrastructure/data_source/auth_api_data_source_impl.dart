import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/account/auth/domain/external/auth_external_data_source.dart';
import 'package:emotional_app/features/account/auth/domain/entities/login_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/sign_up_credentials.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/infrastructure/exceptions/invalid_credentials.dart';
import 'package:emotional_app/features/account/auth/infrastructure/mapper/token_login_api_mapper.dart';
import 'package:emotional_app/features/account/auth/infrastructure/dto/auth_api_response.dart';
import 'package:emotional_app/shared/infrastructure/exceptions/http_exception.dart';
import 'package:dio/dio.dart';

class AuthApiDataSourceImpl implements AuthExternalDataSource {
  @override
  Future<Token> login(LoginCredentials authCredentials) async {
    try {
      final response = await AppHttpSingleton().post(
        '/auth/login',
        data: {
          'email': authCredentials.email,
          'password': authCredentials.password,
        },
      );
      return TokenApiMapper.fromApi(AuthApiResponse.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw InvalidCredentialsException();
      throw HttpException();
    } catch (e) {
      throw HttpException();
    }
  }

  @override
  Future<Token> signUp(SignUpCredentials signUpCredentials) async {
    try {
      final response = await AppHttpSingleton().post(
        '/auth/signup',
        data: {
          'username': signUpCredentials.username,
          'email': signUpCredentials.email,
          'password': signUpCredentials.password,
          'birthDate': signUpCredentials.birthDate.toString(),
          'mobileNumber': signUpCredentials.phoneNumber,
          'firstName': signUpCredentials.firstName,
          'lastName': signUpCredentials.lastName,
        },
      );
      return TokenApiMapper.fromApi(
        AuthApiResponse.fromJson(
          response.data,
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) throw InvalidCredentialsException();
      throw HttpException();
    } catch (e) {
      throw HttpException();
    }
  }
}
