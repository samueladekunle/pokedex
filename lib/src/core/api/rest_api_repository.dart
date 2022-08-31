import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pokedex/src/config/constants.dart';
import 'package:pokedex/src/core/exceptions/exceptions.dart';
import 'package:pokedex/src/core/extensions/dio_extensions.dart';

class RestAPIRepository {
  final Dio _dio;

  const RestAPIRepository({required Dio dio}) : _dio = dio;

  Either<AppException, JsonResponse> _parseResponse(Response response) {
    if (response.isSuccessful) {
      if (response.data is JsonResponse) {
        return Either.right(response.data);
      }
      return Either.right({'data': response.data});
    }
    return Either.left(const AppException());
  }

  Future<Either<AppException, JsonResponse>> get(String path) async {
    try {
      final response = await _dio.get(path);
      return _parseResponse(response);
    } on DioError catch (e) {
      return Left(AppException.fromDioError(e));
    }
  }
}

final restAPIRepositoryProvider = Provider<RestAPIRepository>((ref) {
  final dio = Dio(BaseOptions(baseUrl: kPokeAPIBaseUrl));
  return RestAPIRepository(dio: dio);
});
