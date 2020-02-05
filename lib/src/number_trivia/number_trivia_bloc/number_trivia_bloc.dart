import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_bloc/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_service.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:meta/meta.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  static const _conversionFailureMessage = 'number conversion failed';

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
        throw UnimplementedError();
      });
    }
  }
}
