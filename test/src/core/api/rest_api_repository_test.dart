import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/src/core/api/rest_api_repository.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final MockDio dio;
  late final RestAPIRepository restAPIRepository;

  setUpAll(() {
    dio = MockDio();
    restAPIRepository = RestAPIRepository(dio: dio);
  });

  group('.get', () {
    test(
        'Given a status code of 200, Either.right() is true and Either.isLeft() is false',
        () async {
      when(() => dio.get(any())).thenAnswer(
        (invocation) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );
      final either = await restAPIRepository.get("/");
      expect(either.isRight(), true);
      expect(either.isLeft(), false);
    });

    test(
        'Given a status code of 400, Either.isRight() is false and Either.isLeft() is true',
        () async {
      when(() => dio.get(any())).thenAnswer(
        (invocation) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
        ),
      );
      final either = await restAPIRepository.get("/");
      expect(either.isRight(), false);
      expect(either.isLeft(), true);
    });
  });
}
