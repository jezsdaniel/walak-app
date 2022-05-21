import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/payments/models/models.dart';
import 'package:walak/modules/payments/repository/payments_repository.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState>
    with NetworkErrorHandler {
  final PaymentsRepository _paymentsRepository;

  PaymentsBloc(this._paymentsRepository) : super(PaymentsState()) {
    on<PaymentsEventGetPaymentsHistory>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.inProgress));
      final res = await _paymentsRepository.getPaymentsHistory(
        event.from,
        event.to,
        event.status,
      );
      if (res is ResultSuccess<List<SourceTransaction>>) {
        emit(state.copyWith(
          payments: res.value,
          status: RequestStatus.success,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: getErrorFromResult(res),
          status: RequestStatus.failure,
        ));
      }
    });

    on<PaymentsEventAddPayment>((event, emit) async {
      emit(state.copyWith(status: RequestStatus.inProgress));
      final res = await _paymentsRepository.addPayment(
        event.amount,
        event.paymentMethodId,
        event.code,
        event.name,
      );
      if (res is ResultSuccess<bool> && res.value) {
        emit(state.copyWith(
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
