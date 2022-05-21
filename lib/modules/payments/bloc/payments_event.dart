part of 'payments_bloc.dart';

@immutable
abstract class PaymentsEvent {}

class PaymentsEventGetPaymentsHistory extends PaymentsEvent {
  final DateTime from;
  final DateTime to;
  final int? status;

  PaymentsEventGetPaymentsHistory({
    required this.from,
    required this.to,
    this.status,
  });
}

class PaymentsEventAddPayment extends PaymentsEvent {
  final double amount;
  final int paymentMethodId;
  final String? code;
  final String? name;

  PaymentsEventAddPayment({
    required this.amount,
    required this.paymentMethodId,
    this.code,
    this.name,
  });
}
