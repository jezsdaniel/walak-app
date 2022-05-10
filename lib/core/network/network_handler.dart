import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/auth/bloc/auth_bloc.dart';

class NetworkHandler {
  late Dio dio;

  NetworkHandler._internal();

  static final _singleton = NetworkHandler._internal();

  factory NetworkHandler() => _singleton;

  void init({required AuthBloc authBloc}) {
    dio = createDio(authBloc);
  }

  Dio createDio(AuthBloc authBloc) {
    var options = BaseOptions(
      baseUrl: Endpoints.apiBaseUrl,
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Accept-Language': 'es',
      },
    );
    final dio = Dio(options);
    dio.interceptors.addAll([
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
      AuthInterceptor(dio, authBloc: authBloc),
    ]);
    return dio;
  }
}

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final storage = const FlutterSecureStorage();
  final AuthBloc authBloc;

  AuthInterceptor(this.dio, {required this.authBloc});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['requiresAuth'] == false) {
      options.headers.remove('requiresAuth');
      return handler.next(options);
    }

    final accessToken = await storage.read(key: 'accessToken');
    final refreshToken = await storage.read(key: 'refreshToken');

    if (accessToken == null || refreshToken == null) {
      performLogout(dio);

      options.extra['tokenErrorType'] = 'tokenNotFound';
      final error = DioError(requestOptions: options, type: DioErrorType.other);
      return handler.reject(error);
    }

    final accessTokenHasExpired = JwtDecoder.isExpired(accessToken);

    var refreshed = true;

    if (accessTokenHasExpired) {
      refreshed = await regenerateAccessToken(dio);
    }

    if (refreshed) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    } else {
      options.extra['tokenErrorType'] = 'failedToRegenerateAccessToken';
      final error = DioError(requestOptions: options, type: DioErrorType.other);
      return handler.reject(error);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      performLogout(dio);

      err.type = DioErrorType.other;
      err.requestOptions.extra['tokenErrorType'] = 'tokenErrorType';
    }

    return handler.next(err);
  }

  void performLogout(Dio dio) {
    storage.deleteAll();
    authBloc.add(AuthEventSignOut());
  }

  Future<bool> regenerateAccessToken(Dio dio) async {
    try {
      final refreshToken = await storage.read(key: 'refreshToken');

      final response = await dio.post(
        Endpoints.refreshToken,
        queryParameters: {
          'refreshToken': refreshToken,
        },
        options: Options(
          headers: {
            'requiresAuth': false,
          },
        ),
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];
        storage.write(key: 'accessToken', value: newAccessToken);
        storage.write(key: 'refreshToken', value: newRefreshToken);
        return true;
      } else {
        performLogout(dio);
        return false;
      }
    } on DioError {
      return false;
    } catch (e) {
      return false;
    }
  }
}
