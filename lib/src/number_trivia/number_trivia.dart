import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({
    @required this.text,
    @required this.number,
  }) : super([text, number]);

  factory NumberTrivia.fromJson(Map<String, dynamic> jsonMap) {
    return NumberTrivia(
      text: jsonMap['text'],
      number: (jsonMap['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}

class NumberTriviaRepository {
  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(int number) {}
}
