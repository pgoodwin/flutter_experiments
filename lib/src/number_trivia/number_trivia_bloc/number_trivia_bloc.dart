import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_bloc/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_service.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:meta/meta.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  static const _conversionFailureMessage = 'number conversion failed';
  static const _serverFailureMessage = 'server failure';

  final NumberTriviaService numberTriviaService;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {@required this.numberTriviaService, @required this.inputConverter});

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputNumber =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputNumber.fold((exception) async* {
        yield Error(message: _conversionFailureMessage);
      }, (number) async* {
        yield Loading();

        final exceptionOrTrivia =
            await numberTriviaService.getNumberTrivia(number: number);
        yield exceptionOrTrivia.fold(
            (exception) => Error(message: _serverFailureMessage),
            (trivia) => Loaded(trivia: trivia));
      });
    }
  }
}
