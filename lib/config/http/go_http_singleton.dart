import 'package:dio/dio.dart';
import 'package:emotional_app/config/env/app_environment.dart';
import 'package:emotional_app/features/account/auth/infrastructure/data_source/auth_local_data_source_impl.dart';
import 'package:emotional_app/features/account/auth/infrastructure/repository/auth_local_repository_impl.dart';

class GoHttpSingleton {
  final _authLocalRepo = AuthLocalRepositoryImpl(
    AuthLocalDataSourceImpl(),
  );

  late Dio _dioGoApi;
  static final _instance = GoHttpSingleton._internal();

  factory GoHttpSingleton() => _instance;

  GoHttpSingleton._internal() {
    initializeDio();
  }

  void initializeDio() {
    _dioGoApi = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.goApiUrl,
      ),
    );

    _dioGoApi.interceptors.add(
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

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return _dioGoApi.get(
      url,
      queryParameters: params,
    );
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    return _dioGoApi.post(url, data: data);
  }

  Future<Response> delete(String url, {Map<String, dynamic>? data}) async {
    return _dioGoApi.delete(url, data: data);
  }
}
