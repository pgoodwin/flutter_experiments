import 'package:dartz/dartz.dart';
import 'package:flutter_experiments/core/platform/network_info.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_local_data_source.dart';
import 'package:flutter_experiments/src/number_trivia/number_trivia_remote_data_source.dart';
import 'package:meta/meta.dart';

class RemoteNumberTriviaRepository implements NumberTriviaRepository {
  NumberTriviaRemoteDataSource remoteDataSource;
  NumberTriviaLocalDataSource localDataSource;
  NetworkInfo networkInfo;

  RemoteNumberTriviaRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  Future<Either<Exception, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    try {
      if (await networkInfo.isConnected) {
        final trivia = await remoteDataSource.getConcreteNumberTrivia(number);
        localDataSource.cacheNumberTrivia(trivia);
        return Right(trivia);
      } else {
        return Right(await localDataSource.getLastNumberTrivia());
      }
    } catch (e) {
      return Left(e);
    }
  }
}
