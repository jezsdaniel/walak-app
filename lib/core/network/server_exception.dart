class ServerException implements Exception {
  String? name;
  String? message;
  int? code;

  ServerException({this.code, this.message});

  ServerException.fromJson(this.code, dynamic json) {
    final error = json;
    if (error is Map<String, dynamic>) {
      name = error['response']['name'];
      message = error['response']['message'];
    } else {
      message = error.toString();
    }
    code = code;
  }
}
