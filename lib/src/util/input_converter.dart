import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/src/error/exception.dart';

class InputConverter {
  Either<Exception, int> stringToUnsignedInteger(String str) {
    try {
      var value = int.parse(str);
      if (value >= 0) {
        return Right(value);
      }
    } on Exception {}

    return Left(InvalidInputException());
  }
}
