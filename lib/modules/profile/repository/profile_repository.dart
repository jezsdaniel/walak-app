import 'package:walak/core/network/network.dart';
import 'package:walak/modules/profile/models/models.dart';

abstract class ProfileRepository {
  Future<Result<User>> me();

  Future<Result<bool>> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  );
}
