import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import '../fakes/fake_shared_preferences.dart';
import '../fixtures/fixture_reader.dart';

void main() {
  NumberTriviaLocalDataSource subject;
  FakeSharedPreferences fakeSharedPreferences;

  setUp(() {
    fakeSharedPreferences = FakeSharedPreferences();
    subject = NumberTriviaLocalDataSource(
      sharedPreferences: fakeSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final expectedTrivia =
        NumberTrivia.fromJson(jsonFromFixture('trivia_cached.json'));

    test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
        () async {
      fakeSharedPreferences
          .alwaysReturn(stringFromFixture('trivia_cached.json'));

      final result = await subject.getLastNumberTrivia();

      expect(result, equals(expectedTrivia));
    });

    test('should throw a CacheException when there is not a cached value', () {
      fakeSharedPreferences.clearFake();

      final call = subject.getLastNumberTrivia;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });

    test('should cache data and then return it', () async {
      fakeSharedPreferences.clearFake();

      subject.cacheNumberTrivia(expectedTrivia);
      final result = await subject.getLastNumberTrivia();

      expect(result, equals(expectedTrivia));
    });
  });
}
