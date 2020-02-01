import 'package:flutter/cupertino.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_experiments/src/failures/failure.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> execute({@required int number}) {
    return numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
