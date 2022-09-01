import 'package:dio/dio.dart';
import 'package:pokedex/src/config/constants.dart';
import 'package:pokedex/src/core/extensions/dio_extensions.dart';

class AppException implements Exception {
  final int statusCode;
  final String statusMessage;

  const AppException({
    this.statusMessage = kDefaultErrorMessage,
    this.statusCode = 0,
  });

  factory AppException.fromDioError(DioError e) {
    final response = e.response;
    final statusCode = response?.statusCode ?? 0;
    final statusMessage = response?.statusMessage ?? '';

    if (response != null) {
      if (response.isServerError) {
        return ServerException(
            statusMessage: statusMessage, statusCode: statusCode);
      } else if (response.isUnauthorised) {
        return UnauthorisedException(statusMessage: statusMessage);
      } else if (response.isForbidden) {
        return ForbiddenException(statusMessage: statusMessage);
      }
      return AppException(statusMessage: statusMessage, statusCode: statusCode);
    }

    return AppException(statusMessage: e.reasonPhrase, statusCode: statusCode);
  }

  @override
  String toString() => statusMessage;
}

class ServerException extends AppException {
  const ServerException({
    required super.statusMessage,
    required super.statusCode,
  });
}

class UnauthorisedException extends AppException {
  const UnauthorisedException({
    required super.statusMessage,
    super.statusCode = kUnauthorisedStatusCode,
  });
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    required super.statusMessage,
    super.statusCode = kForbiddenStatusCode,
  });
}
