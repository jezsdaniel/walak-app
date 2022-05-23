part of 'mlc24_bloc.dart';

@immutable
abstract class MLC24Event {}

class MLC24EventGetHistory extends MLC24Event {
  final DateTime from;
  final DateTime to;
  final int? status;

  MLC24EventGetHistory({
    required this.from,
    required this.to,
    this.status,
  });
}

class MLC24EventCalculateFee extends MLC24Event {
  final int amount;
  final bool isAmountPay;
  final CancelToken cancelToken;

  MLC24EventCalculateFee({
    required this.amount,
    this.isAmountPay = false,
    required this.cancelToken,
  });
}

class MLC24EventCleanFee extends MLC24Event {
  MLC24EventCleanFee();
}

class MLC24EventAddTransaction extends MLC24Event {
  final int amount;
  final double amountPay;
  final double fee;
  final String cardNumber;
  final String senderName;

  MLC24EventAddTransaction({
    required this.amount,
    required this.amountPay,
    required this.fee,
    required this.cardNumber,
    required this.senderName,
  });
}
