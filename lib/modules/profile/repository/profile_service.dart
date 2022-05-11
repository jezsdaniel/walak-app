import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/profile/models/models.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';

class ProfileService implements ProfileRepository {
  final storage = const FlutterSecureStorage();

  @override
  Future<Result<User>> me() async {
    try {
      final userId = await storage.read(key: 'userId');
      final res = await NetworkHandler().dio.get(
            Endpoints.getUserProfile + '/$userId',
          );
      if (res.statusCode == Endpoints.codeSuccess) {
        final userRes = User.fromMap(res.data);
        return Result.success(
          value: userRes,
        );
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }

  @override
  Future<Result<bool>> changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      final res = await NetworkHandler().dio.post(
        Endpoints.changePassword,
        queryParameters: {
          'email': email,
        },
        data: {
          'oldPAssword': oldPassword,
          'newPassword': newPassword,
        },
      );
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(
          value: true,
        );
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }
}
