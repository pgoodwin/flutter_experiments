import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final expectedNumberTrivia = NumberTrivia(number: 1, text: 'Test Text');

  group('json conversion', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      final jsonMap = jsonFromFixture('trivia.json');

      final result = NumberTrivia.fromJson(jsonMap);

      expect(result, expectedNumberTrivia);
    });

    test(
        'should return a valid model when the JSON number is expressed as a double',
        () async {
      final jsonMap = jsonFromFixture('trivia_double.json');

      final result = NumberTrivia.fromJson(jsonMap);

      expect(result, expectedNumberTrivia);
    });

    test('should return a JSON map containing the proper data', () async {
      final result = expectedNumberTrivia.toJson();

      final expectedJsonMap = {'text': 'Test Text', 'number': 1};

      expect(result, expectedJsonMap);
    });
  });
}
