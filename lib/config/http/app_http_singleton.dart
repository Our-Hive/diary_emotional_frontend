import 'package:dio/dio.dart';
import 'package:emotional_app/config/env/app_environment.dart';
import 'package:emotional_app/features/account/auth/domain/entities/token.dart';
import 'package:emotional_app/features/account/auth/infrastructure/data_source/auth_local_data_source_impl.dart';
import 'package:emotional_app/features/account/auth/infrastructure/repository/auth_local_repository_impl.dart';

class AppHttpSingleton {
  late Dio _dioMainApi;
  static final _instance = AppHttpSingleton._internal();

  factory AppHttpSingleton() => _instance;

  AppHttpSingleton._internal() {
    initializeDio();
  }

  void initializeDio() {
    final token = _getToken();
    _dioMainApi = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.apiUrl,
        headers: {
          if (token != null) 'Authorization': 'Bearer ${token.accessToken}',
        },
      ),
    );

    _dioMainApi.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Token? _getToken() => AuthLocalRepositoryImpl(
        AuthLocalDataSourceImpl(),
      ).getAuthToken();

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return _dioMainApi.get(
      url,
      queryParameters: params,
    );
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    return _dioMainApi.post(url, data: data);
  }

  Future<Response> delete(String url, {Map<String, dynamic>? data}) async {
    return _dioMainApi.delete(url, data: data);
  }
}
