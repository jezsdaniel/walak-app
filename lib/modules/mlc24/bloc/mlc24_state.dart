part of 'mlc24_bloc.dart';

class MLC24State {
  final List<MLC24Transaction> transactions;
  final ServiceFee fee;

  final RequestStatus status;
  final RequestStatus feeStatus;
  final String errorMessage;

  MLC24State({
    this.transactions = const [],
    this.fee = const ServiceFee(
      amount: 0,
      amountPay: 0,
      amountToReceive: 0,
      fee: 0,
    ),
    this.feeStatus = RequestStatus.initial,
    this.status = RequestStatus.initial,
    this.errorMessage = '',
  });

  MLC24State copyWith({
    List<MLC24Transaction>? transactions,
    ServiceFee? fee,
    RequestStatus? feeStatus,
    RequestStatus? status,
    String? errorMessage,
  }) {
    return MLC24State(
      transactions: transactions ?? this.transactions,
      fee: fee ?? this.fee,
      feeStatus: feeStatus ?? RequestStatus.initial,
      status: status ?? RequestStatus.initial,
      errorMessage: errorMessage ?? '',
    );
  }
}
