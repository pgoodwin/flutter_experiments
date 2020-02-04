import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      final str = '123';

      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, Right(123));
    });

    test(
        'should return an InvalidInputException when the string does not represent an integer',
        () async {
      final str = '1.23';

      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, equals(Left(InvalidInputException())));
    });

    test(
        'should return an InvalidInputException when the string represents a negative integer',
        () async {
      final str = '-7';

      final result = inputConverter.stringToUnsignedInteger(str);

      expect(result, equals(Left(InvalidInputException())));
    });
  });
}
