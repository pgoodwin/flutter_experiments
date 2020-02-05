import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_bloc/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_service.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockNumberTriviaService extends Mock implements NumberTriviaService {}

void main() {
  NumberTriviaBloc subject;
  MockNumberTriviaService mockNumberTriviaService;
  final validInput = '1';
  final invalidInput = 'invalid';
  final expectedTrivia = NumberTrivia.fromJson(jsonFromFixture('trivia.json'));

  setUp(() {
    mockNumberTriviaService = MockNumberTriviaService();

    subject = NumberTriviaBloc(
      numberTriviaService: mockNumberTriviaService,
      inputConverter: InputConverter(),
    );
  });

  test(
    'should emit [Error] when the input is invalid',
    () async {
      final expected = [
        Empty(),
        Error(message: 'number conversion failed'),
      ];
      expectLater(subject.state, emitsInOrder(expected));

      subject.dispatch(GetTriviaForConcreteNumber(invalidInput));
    },
  );

  group('when service returns valid values', () {
    setUp(() {
      when(mockNumberTriviaService.getNumberTrivia(number: anyNamed('number')))
          .thenAnswer((_) async => Right(expectedTrivia));
    });

    test('should return value from service when input is valid', () async {
      final expected = [
        Empty(),
        Loading(),
        Loaded(trivia: expectedTrivia),
      ];

      expectLater(subject.state, emitsInOrder(expected));

      subject.dispatch(GetTriviaForConcreteNumber(validInput));
    });
  });

  group('when service returns failure', () {
    setUp(() {
      when(mockNumberTriviaService.getNumberTrivia(number: anyNamed('number')))
          .thenAnswer((_) async => Left(ServerException()));
    });

    test('should return error from service even when input is valid', () async {
      final expected = [
        Empty(),
        Loading(),
        Error(message: 'server failure'),
      ];

      expectLater(subject.state, emitsInOrder(expected));

      subject.dispatch(GetTriviaForConcreteNumber(validInput));
    });
  });
}
