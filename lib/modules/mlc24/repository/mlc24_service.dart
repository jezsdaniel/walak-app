import '../../../core/network/network.dart';
import '../models/models.dart';
import 'mlc24_repository.dart';

class MLC24Service implements MLC24Repository {
  @override
  Future<Result<List<MLC24Transaction>>> getMLC24History(
      DateTime from, DateTime to, int? status) async {
    try {
      final Map<String, dynamic> params = {
        'InitDate': from.toIso8601String(),
        'FinishDate': to.toIso8601String(),
      };

      if (status != null) {
        params['status'] = status;
      }

      final res = await NetworkHandler().dio.get(
            Endpoints.transferRequest,
            queryParameters: params,
          );
      if (res.statusCode == Endpoints.codeSuccess) {
        return Result.success(value: mlc24TransactionListFromMap(res.data));
      } else {
        throw ServerException.fromJson(res.statusCode, res.data);
      }

    } catch (ex) {
      return Result.error(error: ex);
    }
  }
}
