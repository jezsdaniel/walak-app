part of 'source_bloc.dart';

class SourceState {
  final SourceBalance? balance;
  final List<PaymentMethod> paymentMethods;

  final RequestStatus balanceStatus;
  final RequestStatus paymentMethodsStatus;
  final String errorMessage;

  SourceState({
    this.balance,
    this.paymentMethods = const [],
    this.balanceStatus = RequestStatus.initial,
    this.paymentMethodsStatus = RequestStatus.initial,
    this.errorMessage = '',
  });

  SourceState copyWith({
    SourceBalance? balance,
    List<PaymentMethod>? paymentMethods,
    RequestStatus? balanceStatus,
    RequestStatus? paymentMethodsStatus,
    String? errorMessage,
  }) {
    return SourceState(
      balance: balance ?? this.balance,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      balanceStatus: balanceStatus ?? RequestStatus.initial,
      paymentMethodsStatus: paymentMethodsStatus ?? RequestStatus.initial,
      errorMessage: errorMessage ?? '',
    );
  }
}
