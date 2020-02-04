import 'package:flutter_experiments/src/number_trivia/number_trivia_bloc/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_service.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaService extends Mock implements NumberTriviaService {}

void main() {
  NumberTriviaBloc subject;
  MockNumberTriviaService mockNumberTriviaService;
  final invalidInput = 'invalid';

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
}
