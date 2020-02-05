import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/domain/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/domain/number_trivia_service.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:meta/meta.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  static const _conversionFailureMessage = 'number conversion failed';
  static const _serverFailureMessage = 'server failure';
  static const _cacheFailureMessage = 'cache failure';

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
            (exception) => Error(message: messageForException(exception)),
            (trivia) => Loaded(trivia: trivia));
      });
    }
  }

  String messageForException(Exception exception) {
    switch (exception.runtimeType) {
      case ServerException:
        return _serverFailureMessage;
      case CacheException:
        return _cacheFailureMessage;
      default:
        return 'unknown failure type';
    }
  }
}
