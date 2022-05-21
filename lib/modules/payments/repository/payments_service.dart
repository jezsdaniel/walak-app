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
            Endpoints.depositRequest,
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

  @override
  Future<Result<bool>> addPayment(
      double amount, int paymentMethodId, String? code, String? name) async {
    try {
      final Map<String, dynamic> body = {
        'amount': amount,
        'paymentMethod': paymentMethodId,
      };

      if (code != null) {
        body['verificationCode'] = code;
      }

      if (name != null) {
        body['senderName'] = name;
      }

      final res = await NetworkHandler().dio.post(
            Endpoints.depositRequest,
            data: body,
          );
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(value: true);
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }
}
