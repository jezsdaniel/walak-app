import 'package:walak/core/network/network.dart';
import 'package:walak/modules/source/models/models.dart';

abstract class SourceRepository {
  Future<Result<SourceBalance>> getBalance();

  Future<Result<List<PaymentMethod>>> getPaymentMethods();
}
