import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/network/network.dart';
import '../../services/models/models.dart';
import '../../services/repository/services_repository.dart';
import '../models/models.dart';
import '../repository/mlc24_repository.dart';

part 'mlc24_event.dart';
part 'mlc24_state.dart';

class MLC24Bloc extends Bloc<MLC24Event, MLC24State> with NetworkErrorHandler {
  final MLC24Repository _mlc24Repository;
  final ServicesRepository _servicesRepository;

  MLC24Bloc(this._mlc24Repository, this._servicesRepository)
      : super(MLC24State()) {
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

    on<MLC24EventCalculateFee>((event, emit) async {
      emit(state.copyWith(feeStatus: RequestStatus.inProgress));
      final res = await _servicesRepository.calculateFee(
        serviceId: 2,
        amount: event.amount,
        isAmountPay: event.isAmountPay,
        cancelToken: event.cancelToken,
      );
      if (res is ResultSuccess<ServiceFee>) {
        emit(state.copyWith(
          fee: res.value,
          feeStatus: RequestStatus.success,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: getErrorFromResult(res),
          feeStatus: RequestStatus.failure,
        ));
      }
    });

    on<MLC24EventCleanFee>((event, emit) {
      emit(state.copyWith(
        fee: const ServiceFee(
          amount: 0,
          amountPay: 0,
          amountToReceive: 0,
          fee: 0,
        ),
        feeStatus: RequestStatus.initial,
      ));
    });

    on<MLC24EventAddTransaction>(((event, emit) async {
      emit(state.copyWith(feeStatus: RequestStatus.inProgress));
      final res = await _mlc24Repository.sendRequest(
        event.amount,
        event.amountPay,
        event.fee,
        event.cardNumber,
        event.senderName,
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
    }));
  }
}
