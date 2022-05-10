import 'package:walak/modules/auth/models/models.dart';
import 'package:walak/modules/services/models/models.dart';

SignInResponse signInResponseFromJson(dynamic str) =>
    SignInResponse.fromJson(str);

class SignInResponse {
  SignInResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.auth,
    required this.userType,
    required this.services,
    required this.level,
    required this.userId,
  });

  final int id;
  final String name;
  final String email;
  final AuthResponse auth;
  final int userType;
  final List<WalakService> services;
  final int level;
  final int userId;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        auth: AuthResponse.fromJson(json['auth']),
        userType: json['userType'],
        services: List<WalakService>.from(
            json['services'].map((x) => WalakService.fromJson(x))),
        level: json['level'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'auth': auth.toJson(),
        'userType': userType,
        'services': List<dynamic>.from(services.map((x) => x.toJson())),
        'level': level,
        'userId': userId,
      };
}
