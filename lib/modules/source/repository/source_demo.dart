import 'package:walak/core/network/network.dart';
import 'package:walak/modules/source/models/models.dart';
import 'package:walak/modules/source/repository/source_repository.dart';

class SourceDemo implements SourceRepository {
  @override
  Future<Result<SourceBalance>> getBalance() {
    return Future.delayed(const Duration(seconds: 2), () {
      return Result.success(
        value: SourceBalance(
          id: 1,
          balance: 10.50,
          availableBalance: 5.00,
        ),
      );
    });
  }

  @override
  Future<Result<List<PaymentMethod>>> getPaymentMethods() {
    return Future.delayed(const Duration(seconds: 2), () {
      return Result.success(
        value: [
          PaymentMethod(
            id: 1,
            name: 'zelle',
            isCrypto: false,
            isInternal: false,
            requiresConfirmationCode: true,
          ),
        ],
      );
    });
  }
}
