import '../../profile/models/models.dart';
import '../../source/models/models.dart';

List<SourceTransaction> sourceTransactionListFromMap(List<dynamic> json) =>
    List<SourceTransaction>.from(json.map((x) => SourceTransaction.fromMap(x)));

class SourceTransaction {
  final int id;
  final User user;
  final int type;
  final int status;
  final double amount;
  final PaymentMethod paymentMethod;
  final SourceTransactionDetails details;
  final DateTime creationDate;
  final bool isLocalDeposit;
  final bool showOptions;
  final String? senderName;
  final String? verificationCode;

  SourceTransaction({
    required this.id,
    required this.user,
    required this.type,
    required this.status,
    required this.amount,
    required this.paymentMethod,
    required this.details,
    required this.creationDate,
    required this.isLocalDeposit,
    required this.showOptions,
    this.senderName,
    this.verificationCode,
  });

  factory SourceTransaction.fromMap(Map<String, dynamic> json) {
    return SourceTransaction(
      id: json['id'],
      user: User.fromMap(json['user']),
      type: json['type'],
      status: json['status'],
      amount: json['amount'],
      paymentMethod: PaymentMethod.fromMap(json['paymentMethod']),
      details: SourceTransactionDetails.fromMap(json['details']),
      creationDate: DateTime.parse(json['creationDate']),
      isLocalDeposit: json['isLocalDeposit'],
      showOptions: json['showOptions'],
      senderName: json['senderName'],
      verificationCode: json['verificationCode'],
    );
  }
}

class SourceTransactionDetails {
  final String? observation;

  SourceTransactionDetails({
    this.observation,
  });

  factory SourceTransactionDetails.fromMap(Map<String, dynamic> json) {
    return SourceTransactionDetails(
      observation: json['observation'],
    );
  }
}
