class WalakService {
  WalakService({
    required this.name,
    required this.fee,
    required this.id,
    required this.type,
    required this.typeName,
    required this.title,
    required this.isActive,
  });

  int id;
  String name;
  String title;
  int type;
  String typeName;
  double fee;
  bool isActive;

  factory WalakService.fromJson(Map<String, dynamic> json) => WalakService(
        id: json['id'],
        name: json['name'],
        title: json['title'],
        type: json['type'],
        typeName: json['typeName'],
        fee: json['fee'],
        isActive: json['isActive'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'title': title,
        'type': type,
        'typeName': typeName,
        'fee': fee,
        'isActive': isActive,
      };
}
