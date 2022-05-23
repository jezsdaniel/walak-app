import 'package:dio/dio.dart';

import '../../../core/network/network.dart';
import '../models/models.dart';
import 'services_repository.dart';

class ServicesDemo implements ServicesRepository {
  @override
  Future<Result<ServiceFee>> calculateFee({
    required int serviceId,
    required int amount,
    bool isAmountPay = false,
    required CancelToken cancelToken,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      return Result.success(
        value: const ServiceFee(
          amount: 100,
          amountPay: 120,
          amountToReceive: 100,
          fee: 20,
        ),
      );
    });
  }
}
