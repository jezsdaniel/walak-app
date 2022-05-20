import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:walak/core/network/network.dart';
import 'package:walak/modules/source/models/models.dart';
import 'package:walak/modules/source/repository/source_repository.dart';

part 'source_event.dart';
part 'source_state.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState>
    with NetworkErrorHandler {
  final SourceRepository _sourceRepository;

  SourceBloc(this._sourceRepository) : super(SourceState()) {
    on<SourceEventGetBalance>((event, emit) async {
      emit(state.copyWith(balanceStatus: RequestStatus.inProgress));
      final res = await _sourceRepository.getBalance();
      if (res is ResultSuccess<SourceBalance>) {
        emit(state.copyWith(
          balance: res.value,
          balanceStatus: RequestStatus.success,
        ));
      } else {
        emit(state.copyWith(
          balanceStatus: RequestStatus.failure,
        ));
      }
    });

    on<SourceEventGetPaymentMethods>((event, emit) async {
      emit(state.copyWith(paymentMethodsStatus: RequestStatus.inProgress));
      final res = await _sourceRepository.getPaymentMethods();
      if (res is ResultSuccess<List<PaymentMethod>>) {
        emit(state.copyWith(
          paymentMethods: res.value,
          paymentMethodsStatus: RequestStatus.success,
        ));
      } else {
        emit(state.copyWith(
          paymentMethodsStatus: RequestStatus.failure,
        ));
      }
    });
  }
}
