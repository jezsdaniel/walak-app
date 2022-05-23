import '../../../core/network/network.dart';
import '../models/models.dart';

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
