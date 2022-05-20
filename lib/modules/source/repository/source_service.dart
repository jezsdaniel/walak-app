import 'package:walak/core/network/network.dart';
import 'package:walak/modules/source/models/models.dart';
import 'package:walak/modules/source/repository/source_repository.dart';

class SourceService implements SourceRepository {
  @override
  Future<Result<SourceBalance>> getBalance() async {
    try {
      final res = await NetworkHandler().dio.get(Endpoints.getSource);
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(value: SourceBalance.fromMap(res.data));
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }

  @override
  Future<Result<List<PaymentMethod>>> getPaymentMethods() async {
    try {
      final res =
          await NetworkHandler().dio.get(Endpoints.getAllPaymentMethods);
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(value: paymentMethodListFromMap(res.data));
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }
}
