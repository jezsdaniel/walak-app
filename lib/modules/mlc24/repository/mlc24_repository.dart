import '../../../core/network/network.dart';
import '../models/models.dart';

abstract class MLC24Repository {
  Future<Result<List<MLC24Transaction>>> getMLC24History(
    DateTime from,
    DateTime to,
    int? status,
  );
}
