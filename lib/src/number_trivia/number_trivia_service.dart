import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_experiments/src/failures/failure.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';

class NumberTriviaService {
  NumberTriviaRepository numberTriviaRepository;

  NumberTriviaService(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> getNumberTrivia(
      {@required int number}) {
    return numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
