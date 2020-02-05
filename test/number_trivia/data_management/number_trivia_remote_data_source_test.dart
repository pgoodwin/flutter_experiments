import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSource subject;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    subject = NumberTriviaRemoteDataSource(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    final numberToQuery = 1;
    final validTriviaJson = stringFromFixture('trivia.json');
    final validTrivia = NumberTrivia.fromJsonString(validTriviaJson);

    group('when server returns valid trivia', () {
      setUp(() {
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async {
          return http.Response(validTriviaJson, 200);
        });
      });

      test(
          'should preform a GET request on a URL with number being the endpoint and with application/json header',
          () async {
        subject.getConcreteNumberTrivia(numberToQuery);

        verify(mockHttpClient.get('http://numbersapi.com/$numberToQuery',
            headers: {'Content-Type': 'application/json'}));
      });

      test('should return NumberTrivia when the response code is 200 (success)',
          () async {
        final result = await subject.getConcreteNumberTrivia(numberToQuery);

        expect(result, equals(validTrivia));
      });
    });

    group('when server returns error status', () {
      setUp(() {
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response('Something went wrong', 404));
      });

      test('should throw ServerException when status is not 2xx', () async {
        expect(() => subject.getConcreteNumberTrivia(numberToQuery),
            throwsA(TypeMatcher<ServerException>()));
      });
    });
  });
}
