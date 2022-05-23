import '../models/mlc24_transaction.dart';
import '../../../core/network/result.dart';
import 'mlc24_repository.dart';

class MLC24Demo implements MLC24Repository {
  @override
  Future<Result<List<MLC24Transaction>>> getMLC24History(
      DateTime from, DateTime to, int? status) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Result.success(value: []);
      },
    );
  }

  @override
  Future<Result<bool>> sendRequest(int amount, double amountPay, double fee, String cardNumber, String senderName) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Result.success(value: true);
      },
    );
  }
}
