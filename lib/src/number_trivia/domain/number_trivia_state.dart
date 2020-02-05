import 'package:equatable/equatable.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia}) : super([trivia]);

  @override
  String toString() {
    return 'Loaded{trivia: $trivia}';
  }
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message}) : super([message]);

  @override
  String toString() {
    return 'Error{message: $message}';
  }
}

