import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberTriviaLocalDataSource {
  static const _triviaKey = 'LAST_REPORTED_NUMBER_TRIVIA';
  SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSource({@required this.sharedPreferences});

  /// Gets the cached [NumberTrivia] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTrivia> getLastNumberTrivia() async {
    var lastTriviaAsString = sharedPreferences.getString(_triviaKey);
    if (lastTriviaAsString == null) {
      throw CacheException();
    }
    return NumberTrivia.fromJsonString(lastTriviaAsString);
  }

  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache) async {
    sharedPreferences.setString(_triviaKey, triviaToCache.toJsonString());
  }
}
