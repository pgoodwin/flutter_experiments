import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:meta/meta.dart';

class NumberTriviaService {
  NumberTriviaRepository numberTriviaRepository;

  NumberTriviaService(this.numberTriviaRepository);

  Future<Either<Exception, NumberTrivia>> getNumberTrivia(
      {@required int number}) {
    return numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
