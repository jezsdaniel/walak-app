import 'dart:io';

import 'package:dio/dio.dart';

import 'package:walak/core/network/network.dart';

class NetworkErrorHandler {
  String getErrorFromResult(Result? res) {
    if (res is ResultError) {
      return getResponseError(res.error);
    } else {
      return 'Ha ocurrido un error, intente nuevamente más tarde';
    }
  }

  String getResponseError(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is DioError) {
      if (error.requestOptions.extra['tokenErrorType'] != null &&
          error.requestOptions.extra['tokenErrorType'] == 'tokenErrorType') {
        return 'Su sesión ha expirado, por favor vuelva a iniciar sesión';
      }
      if (error.response != null && error.response!.data != null) {
        if (error.response?.data[('message')] != null) {
          return error.response?.data[('message')];
        } else {
          return 'Ha ocurrido un error, intente nuevamente más tarde';
        }
      } else {
        return 'Ha ocurrido un error, intente nuevamente más tarde';
      }
    } else if (error is SocketException) {
      return 'Error de conexión';
    } else if (error is ServerException) {
      if (error.code == Endpoints.codeUnauthorized) {
        return 'Usuario no autorizado';
      }
      return error.message ??
          'Ha ocurrido un error, intente nuevamente más tarde';
    } else {
      print('NOT HANDLED ERROR: $error');
      return 'Ha ocurrido un error, intente nuevamente más tarde';
    }
  }
}
