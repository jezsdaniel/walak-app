import '../../profile/models/models.dart';
import 'models.dart';

class ServiceTransaction {
  final int id;
  final WalakService service;
  final int status;
  final int type;
  final User agency;
  final double agencyFee;
  final double amount;
  final double amountPay;
  final User? company;
  final DateTime creationDate;
  final DateTime? modificationDate;
  final DateTime? deliveryDate;
  final String? details;
  final String? phoneNumber;
  final User? provider;
  final double? providerFee;
  final List<String> providerProof;
  final String senderName;
  final List<String> verificationCodes;

  ServiceTransaction({
    required this.id,
    required this.service,
    required this.status,
    required this.type,
    required this.agency,
    required this.agencyFee,
    required this.amount,
    required this.amountPay,
    this.company,
    required this.creationDate,
    this.modificationDate,
    this.deliveryDate,
    this.details,
    this.phoneNumber,
    this.provider,
    this.providerFee,
    this.providerProof = const [],
    required this.senderName,
    this.verificationCodes = const [],
  });

  factory ServiceTransaction.fromMap(Map<String, dynamic> json) =>
      ServiceTransaction(
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
            : [],
        senderName: json['senderName'] ?? '',
        verificationCodes: json['verificationCodes'] != null
            ? List<String>.from(json['verificationCodes'])
            : [],
      );
}
