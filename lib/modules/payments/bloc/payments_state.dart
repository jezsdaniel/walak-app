part of 'payments_bloc.dart';

class PaymentsState {
  final List<SourceTransaction> payments;

  final RequestStatus status;
  final String errorMessage;

  PaymentsState({
    this.payments = const [],
    this.status = RequestStatus.initial,
    this.errorMessage = '',
  });

  PaymentsState copyWith({
    List<SourceTransaction>? payments,
    RequestStatus? status,
    String? errorMessage,
  }) {
    return PaymentsState(
      payments: payments ?? this.payments,
      status: status ?? RequestStatus.initial,
      errorMessage: errorMessage ?? '',
    );
  }
}
