import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/auth/models/models.dart';
import 'package:walak/modules/auth/repository/auth_repository.dart';
import 'package:walak/modules/profile/models/models.dart';

class AuthService implements AuthRepository {
  final storage = const FlutterSecureStorage();

  void handleUserAuth(SignInResponse response) {
    storage.write(key: 'accessToken', value: response.auth.accessToken);
    storage.write(key: 'refreshToken', value: response.auth.refreshToken);
    storage.write(key: 'userId', value: response.userId.toString());
  }

  @override
  Future<Result<User>> signIn(String email, String password) async {
    try {
      final res = await NetworkHandler().dio.post(
            Endpoints.signIn,
            data: {
              'email': email,
              'password': password,
            },
            options: Options(
              headers: {
                'requiresAuth': false,
              },
            ),
          );
      if (res.statusCode == Endpoints.codeSuccess) {
        final authRes = signInResponseFromJson(res.data);
        handleUserAuth(authRes);
        return Result.success(
          value: User(
            id: authRes.id,
            userId: authRes.userId,
            name: authRes.name,
            email: authRes.email,
            userType: authRes.userType,
            level: authRes.level,
            services: authRes.services,
          ),
        );
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }

  @override
  Future<Result<bool>> verifyAuth() async {
    final dio = NetworkHandler().dio;
    final refreshToken = await storage.read(key: 'refreshToken');
    final userId = await storage.read(key: 'userId');
    if (refreshToken == null || userId == null) {
      return Result.success(value: false);
    }
    try {
      final res = await dio.post(
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
      if (res.statusCode == Endpoints.codeSuccess) {
        final newAccessToken = res.data['accessToken'];
        final newRefreshToken = res.data['refreshToken'];
        storage.write(key: 'accessToken', value: newAccessToken);
        storage.write(key: 'refreshToken', value: newRefreshToken);
        return Result.success(value: true);
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }

  @override
  Future<Result<bool>> signOut() async {
    storage.deleteAll();
    return ResultSuccess(value: true);
  }
}
