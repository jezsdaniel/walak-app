class ServiceFee {
  final double amount;
  final double amountPay;
  final double amountToReceive;
  final double fee;

  const ServiceFee({
    required this.amount,
    required this.amountPay,
    required this.amountToReceive,
    required this.fee,
  });

  factory ServiceFee.fromMap(Map<String, dynamic> map) {
    return ServiceFee(
      amount: map['amount'] as double,
      amountPay: map['amountPay'] as double,
      amountToReceive: map['amountToRecive'] as double,
      fee: map['fee'] as double,
    );
  }
}
