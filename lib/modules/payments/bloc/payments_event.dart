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
