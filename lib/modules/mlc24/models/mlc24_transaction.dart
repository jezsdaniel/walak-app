import '../../profile/models/models.dart';
import '../../services/models/models.dart';

List<MLC24Transaction> mlc24TransactionListFromMap(List<dynamic> json) =>
    List<MLC24Transaction>.from(json.map((x) => MLC24Transaction.fromMap(x)));

class MLC24Transaction extends ServiceTransaction {
  final String cardNumber;

  MLC24Transaction({
    required int id,
    required WalakService service,
    required int status,
    required int type,
    required User agency,
    required double agencyFee,
    required double amount,
    required double amountPay,
    User? company,
    required DateTime creationDate,
    DateTime? modificationDate,
    DateTime? deliveryDate,
    String? details,
    String? phoneNumber,
    User? provider,
    double? providerFee,
    List<String> providerProof = const [],
    required String senderName,
    List<String> verificationCodes = const [],
    required this.cardNumber,
  }) : super(
          id: id,
          service: service,
          status: status,
          type: type,
          agency: agency,
          agencyFee: agencyFee,
          amount: amount,
          amountPay: amountPay,
          company: company,
          creationDate: creationDate,
          modificationDate: modificationDate,
          deliveryDate: deliveryDate,
          details: details,
          phoneNumber: phoneNumber,
          provider: provider,
          providerFee: providerFee,
          providerProof: providerProof,
          senderName: senderName,
          verificationCodes: verificationCodes,
        );

  factory MLC24Transaction.fromMap(Map<String, dynamic> json) =>
      MLC24Transaction(
        id: json['id'],
        service: WalakService.fromJson(json['service']),
        status: json['status'],
        type: json['type'],
        agency: User.fromMap(json['agency']),
        agencyFee: json['agencyFee'],
        amount: json['amount'],
        amountPay: json['amountPay'],
        company: json['company'] != null ? User.fromMap(json['company']) : null,
        creationDate: DateTime.parse(json['creationDate']),
        modificationDate: json['modificationDate'] != null
            ? DateTime.parse(json['modificationDate'])
            : null,
        deliveryDate: json['deliveryDate'] != null
            ? DateTime.parse(json['deliveryDate'])
            : null,
        details: json['details'],
        phoneNumber: json['phoneNumber'],
        provider:
            json['provider'] != null ? User.fromMap(json['provider']) : null,
        providerFee: json['providerFee'],
        providerProof: json['providerProof'] != null
            ? List<String>.from(json['providerProof'])
            : const [],
        senderName: json['senderName'],
        verificationCodes: json['verificationCodes'] != null
            ? List<String>.from(json['verificationCodes'])
            : [],
        cardNumber: json['cardNumber'],
      );
}
