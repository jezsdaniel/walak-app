import 'package:walak/core/network/network.dart';
import 'package:walak/modules/auth/repository/auth_repository.dart';
import 'package:walak/modules/profile/models/models.dart';

class AuthDemo implements AuthRepository {
  @override
  Future<Result<User>> signIn(String email, String password) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Result.success(
          value: User(
            id: 123,
            userId: 123,
            name: 'Juan',
            email: 'juanperez@mail.com',
            userType: 1,
            level: 2,
            services: [],
          ),
        );
        // return ResultError(error: 'Ups :/');
      },
    );
  }

  @override
  Future<Result<bool>> verifyAuth() {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Result.success(
          value: true,
        );
        // return ResultError(error: 'Ups :/');
      },
    );
  }

  @override
  Future<Result<bool>> signOut() {
    return Future.delayed(const Duration(seconds: 2), () {
      return Result.success(value: true);
      // return ResultError(error: 'Ups :/');
    });
  }
}
