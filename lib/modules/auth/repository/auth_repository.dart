import 'package:walak/core/network/network.dart';
import 'package:walak/modules/profile/models/models.dart';

abstract class AuthRepository {
  Future<Result<User>> signIn(String email, String password);

  Future<Result<bool>> verifyAuth();

  Future<Result<bool>> signOut();
}
