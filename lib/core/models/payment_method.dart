List<PaymentMethod> paymentMethodListFromMap(List<dynamic> json) =>
    List<PaymentMethod>.from(json.map((x) => PaymentMethod.fromMap(x)));

class PaymentMethod {
  final int id;
  final String name;
  final String? url;
  final String? qrUrl;
  final double? fee;
  final bool isCrypto;
  final bool isInternal;
  final bool requiresConfirmationCode;

  PaymentMethod({
    required this.id,
    required this.name,
    this.url,
    this.qrUrl,
    this.fee,
    required this.isCrypto,
    required this.isInternal,
    required this.requiresConfirmationCode,
  });

  factory PaymentMethod.fromMap(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      qrUrl: json['qrUrl'],
      fee: json['fee'],
      isCrypto: json['isCrypto'],
      isInternal: json['isInternal'],
      requiresConfirmationCode: json['requiresConfirmationCode'],
    );
  }

  String get title {
    switch (name) {
      case 'bank-transfer':
        return 'Transferencia bancaria';
      case 'cash':
        return 'Efectivo';
      case 'paycheck':
        return 'Cheque';
      case 'credit-card':
        return 'Tarjeta de crédito';
      case 'dai':
        return 'DAI';
      case 'cashapp':
        return 'CashApp';
      case 'paypal':
        return 'PayPal';
      case 'usd-coin':
        return 'USD Coin';
      case 'usdt':
        return 'USDT';
      case 'USDT':
        return 'USDT';
      case 'venmo':
        return 'Venmo';
      case 'zelle':
        return 'Zelle';
      case 'walak-credit':
        return 'Saldo Walak';
      default:
        return '';
    }
  }
}
