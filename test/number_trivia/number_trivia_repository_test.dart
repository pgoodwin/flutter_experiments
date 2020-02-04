import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/core/platform/network_info.dart';
import 'package:flutter_experiments/src/error/exception.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_local_data_source.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_remote_data_source.dart';
import 'package:flutter_experiments/src/number_trivia/remote_number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  RemoteNumberTriviaRepository subject;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    subject = RemoteNumberTriviaRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', () {
    // DATA FOR THE MOCKS AND ASSERTIONS
    // We'll use these three variables throughout all the tests
    final inputNumber = 1;
    final expectedNumber = 1;
    final expectedNumberTrivia =
        NumberTrivia(number: expectedNumber, text: 'test trivia');

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getConcreteNumberTrivia(inputNumber))
            .thenAnswer((_) async => expectedNumberTrivia);
      });

      test('retrieve from remote and cache locally when successful', () async {
        final result = await subject.getConcreteNumberTrivia(inputNumber);

        expect(result, equals(Right(expectedNumberTrivia)));

        verify(mockLocalDataSource.cacheNumberTrivia(expectedNumberTrivia));
      });

      test('return exception when retreival is unsuccessful', () async {
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final result = await subject.getConcreteNumberTrivia(inputNumber);

        expect(result, equals(Left(ServerException())));

        verifyZeroInteractions(mockLocalDataSource);
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => expectedNumberTrivia);
      });

      test('return cached data when present', () async {
        final anotherNumber = 3;
        final result = await subject.getConcreteNumberTrivia(anotherNumber);

        expect(result, equals(Right(expectedNumberTrivia)));
      });

      test('return exception when no cached data is present', () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

        final anotherNumber = 3;
        final result = await subject.getConcreteNumberTrivia(anotherNumber);

        expect(result, equals(Left(CacheException())));
      });
    });
  });
}
