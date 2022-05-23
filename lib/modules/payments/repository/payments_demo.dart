import '../../source/models/models.dart';
import '../../../core/network/network.dart';
import '../models/models.dart';
import 'payments_repository.dart';
import '../../profile/models/models.dart';

class PaymentsDemo implements PaymentsRepository {
  @override
  Future<Result<List<SourceTransaction>>> getPaymentsHistory(
    DateTime from,
    DateTime to,
    int? status,
  ) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Result.success(value: [
          SourceTransaction(
            id: 1,
            amount: 10.50,
            creationDate: DateTime.now(),
            isLocalDeposit: false,
            type: 1,
            paymentMethod: PaymentMethod(
              id: 1,
              name: 'zelle',
              isCrypto: false,
              isInternal: false,
              requiresConfirmationCode: true,
            ),
            details: SourceTransactionDetails(
              observation: '',
            ),
            showOptions: true,
            status: 1,
            senderName: 'Juan',
            verificationCode: '12342341',
            user: User(
              id: 123,
              userId: 123,
              name: 'Juan',
              email: 'juanperez@mail.com',
              userType: 1,
              level: 2,
              services: [],
            ),
          ),
        ]);
        // return ResultError(error: 'Ups :/');
      },
    );
  }

  @override
  Future<Result<bool>> addPayment(
      double amount, int paymentMethodId, String? code, String? name) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return Result.success(value: true);
      },
    );
  }
}
