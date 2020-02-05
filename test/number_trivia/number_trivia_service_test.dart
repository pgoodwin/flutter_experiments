import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  NumberTriviaService subject;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    subject = NumberTriviaService(numberTriviaRepository: mockNumberTriviaRepository);
  });

  final inputNumber = 1;
  final expectedNumberTrivia = NumberTrivia(number: inputNumber, text: 'test');

  test(
    'should get trivia for the number from the repository',
        () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(expectedNumberTrivia));

      final result = await subject.getNumberTrivia(number: inputNumber);

      expect(result, Right(expectedNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(inputNumber));

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}