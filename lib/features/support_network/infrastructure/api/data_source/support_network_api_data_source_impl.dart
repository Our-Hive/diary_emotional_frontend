import 'package:dio/dio.dart';
import 'package:emotional_app/config/http/app_http_singleton.dart';
import 'package:emotional_app/features/support_network/domain/data_source/support_network_external_data_source.dart';
import 'package:emotional_app/features/support_network/domain/entities/support_network_member.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/exceptions/user_already_in_network_exception.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/exceptions/user_cannot_support_himself_exception.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/exceptions/user_not_found_exception.dart';
import 'package:emotional_app/features/support_network/infrastructure/api/mappers/support_network_mapper.dart';

class SupportNetworkApiDataSourceImpl
    implements SupportNetworkExternalDataSource {
  @override
  Future<bool> addSupportNetworkByUserName(
    String userName,
  ) async {
    try {
      final response = await AppHttpSingleton().post(
        '/users/support-network',
        data: {
          "username": userName,
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw UserCannotSupportHimselfException();
      }
      if (e.response?.statusCode == 404) {
        throw UserNotFoundException();
      }
      if (e.response?.statusCode == 409) {
        throw UserAlreadyInNetworkException();
      }
    } catch (_) {
      return false;
    }
    return false;
  }

  @override
  Future<List<SupportNetworkMember>> getSupportNetwork() async {
    try {
      final responseMySupports = AppHttpSingleton().get(
        '/users/support-network',
      );
      final responseSupported = AppHttpSingleton().get(
        '/users/supported',
      );

      final response = await Future.wait([
        responseMySupports,
        responseSupported,
      ]);
      final data = SupportNetworkMapper.fromResponse(response);
      return data;
    } catch (_) {
      throw Exception();
    }
  }
}
