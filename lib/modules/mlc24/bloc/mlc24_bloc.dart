import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/network/network.dart';
import '../models/models.dart';
import '../repository/mlc24_repository.dart';

part 'mlc24_event.dart';
part 'mlc24_state.dart';

class MLC24Bloc extends Bloc<MLC24Event, MLC24State> with NetworkErrorHandler {
  final MLC24Repository _mlc24Repository;

  MLC24Bloc(this._mlc24Repository) : super(MLC24State()) {
    on<MLC24EventGetHistory>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.inProgress));
      final res = await _mlc24Repository.getMLC24History(
        event.from,
        event.to,
        event.status,
      );
      if (res is ResultSuccess<List<MLC24Transaction>>) {
        emit(state.copyWith(
          transactions: res.value,
          status: RequestStatus.success,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: getErrorFromResult(res),
          status: RequestStatus.failure,
        ));
      }
    });
  }
}
