import 'package:walak/modules/services/models/models.dart';

class User {
  final int id;
  final int userId;
  final String name;
  final String email;
  final int userType;
  final int level;
  final List<WalakService> services;

  User({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.userType,
    required this.level,
    required this.services,
  });

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      userType: json['userType'],
      level: json['level'],
      services: List<WalakService>.from(
          json['services'].map((x) => WalakService.fromJson(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'email': email,
      'userType': userType,
      'level': level,
      'services': List<dynamic>.from(services.map((x) => x.toJson())),
    };
  }

  User copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    int? userType,
    int? level,
    List<WalakService>? services,
  }) {
    return User(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      level: level ?? this.level,
      services: services ?? this.services,
    );
  }
}
