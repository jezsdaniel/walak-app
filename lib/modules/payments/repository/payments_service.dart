import 'package:walak/core/network/network.dart';
import 'package:walak/modules/payments/models/models.dart';
import 'package:walak/modules/payments/repository/payments_repository.dart';

class PaymentsService implements PaymentsRepository {
  @override
  Future<Result<List<SourceTransaction>>> getPaymentsHistory(
    DateTime from,
    DateTime to,
    int? status,
  ) async {
    try {
      final params = {
        'OnlyAgencies': false,
        'InitDate': from.toIso8601String(),
        'FinishDate': to.toIso8601String(),
      };

      if (status != null) {
        params['Status'] = status;
      }

      final res = await NetworkHandler().dio.get(
            Endpoints.getDepositRequest,
            queryParameters: params,
          );
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(value: sourceTransactionListFromMap(res.data));
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }
}
