import 'package:flutter_experiments/src/number_trivia/get_concrete_number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia subject;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    subject = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final inputNumber = 1;
  final expectedNumberTrivia = NumberTrivia(number: inputNumber, text: 'test');

  test(
    'should get trivia for the number from the repository',
        () async {
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(expectedNumberTrivia));

      final result = await subject.execute(number: inputNumber);

      expect(result, Right(expectedNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(inputNumber));

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );

}