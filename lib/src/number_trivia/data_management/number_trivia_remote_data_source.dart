import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class NumberTriviaRemoteDataSource {
  http.Client client;

  NumberTriviaRemoteDataSource({@required this.client});

  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTrivia> getConcreteNumberTrivia(int number) async {
    final response = await client.get(
      'http://numbersapi.com/$number',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return NumberTrivia.fromJsonString(response.body);
    } else {
      throw ServerException();
    }
  }
}
