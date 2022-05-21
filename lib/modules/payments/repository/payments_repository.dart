import 'package:walak/core/network/network.dart';
import 'package:walak/modules/payments/models/models.dart';

abstract class PaymentsRepository {
  Future<Result<List<SourceTransaction>>> getPaymentsHistory(
    DateTime from,
    DateTime to,
    int? status,
  );

  Future<Result<bool>> addPayment(
    double amount,
    int paymentMethodId,
    String? code,
    String? name,
  );
}
