class SourceBalance {
  final int id;
  final double balance;
  final double availableBalance;

  SourceBalance({
    required this.id,
    required this.balance,
    required this.availableBalance,
  });

  factory SourceBalance.fromMap(Map<String, dynamic> json) {
    return SourceBalance(
      id: json['id'] as int,
      balance: json['balance'] as double,
      availableBalance: json['availableBalance'] as double,
    );
  }
}
