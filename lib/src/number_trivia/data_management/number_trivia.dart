import 'dart:convert';

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

  factory NumberTrivia.fromJsonString(String string) =>
      NumberTrivia.fromJson(json.decode(string));

  Map<String, dynamic> toJson() => {'text': text, 'number': number};

  String toJsonString() => json.encode(this.toJson());

  @override
  String toString() {
    return 'NumberTrivia{text: $text, number: $number}';
  }
}

abstract class NumberTriviaRepository {
  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(int number);
}
