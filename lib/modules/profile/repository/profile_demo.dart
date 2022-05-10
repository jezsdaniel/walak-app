import 'package:walak/modules/profile/models/user.dart';
import 'package:walak/core/network/result.dart';
import 'package:walak/modules/profile/repository/profile_repository.dart';

class ProfileDemo implements ProfileRepository {
  @override
  Future<Result<User>> me() {
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
}
