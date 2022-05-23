import 'package:dio/dio.dart';

import '../../../core/network/network.dart';
import '../models/service_fee.dart';
import 'services_repository.dart';

class ServicesService implements ServicesRepository {
  @override
  Future<Result<ServiceFee>> calculateFee({
    required int serviceId,
    required int amount,
    bool isAmountPay = false,
    required CancelToken cancelToken,
  }) async {
    try {
      final body = {
        'serviceId': serviceId,
        'amount': amount,
        'isAmountPay': isAmountPay,
      };

      final res = await NetworkHandler().dio.post(
            Endpoints.requestFee,
            data: body,
            cancelToken: cancelToken,
          );
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(value: ServiceFee.fromMap(res.data));
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }
    } catch (ex) {
      return Result.error(error: ex);
    }
  }
}
