import 'package:dio/dio.dart';
import 'package:emotional_app/config/env/app_environment.dart';
import 'package:emotional_app/features/account/auth/infrastructure/data_source/auth_local_data_source_impl.dart';
import 'package:emotional_app/features/account/auth/infrastructure/repository/auth_local_repository_impl.dart';

class AppHttpSingleton {
  final _authLocalRepo = AuthLocalRepositoryImpl(
    AuthLocalDataSourceImpl(),
  );

  late Dio _dioMainApi;
  static final _instance = AppHttpSingleton._internal();

  factory AppHttpSingleton() => _instance;

  AppHttpSingleton._internal() {
    initializeDio();
  }

  void initializeDio() {
    _dioMainApi = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.apiUrl,
      ),
    );

    _dioMainApi.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _authLocalRepo.getAuthToken()?.accessToken;
          options.headers.addAll({
            'Authorization': 'Bearer $token',
          });
          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException e, handler) => handler.next(e),
      ),
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    return _dioMainApi.get(
      url,
      queryParameters: params,
    );
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return _dioMainApi.post(url, data: data);
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return _dioMainApi.delete(url, data: data);
  }

  patch(
    String url, {
    Map<String, String>? data,
  }) {
    return _dioMainApi.patch(url, data: data);
  }
}
