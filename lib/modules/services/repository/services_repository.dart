import 'package:dio/dio.dart';

import '../../../core/network/network.dart';
import '../models/models.dart';

abstract class ServicesRepository {
  Future<Result<ServiceFee>> calculateFee({
    required int serviceId,
    required int amount,
    bool isAmountPay = false,
    required CancelToken cancelToken,
  });
}
