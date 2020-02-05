import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_experiments/core/platform/network_info.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia_local_data_source.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/number_trivia_remote_data_source.dart';
import 'package:flutter_experiments/src/number_trivia/data_management/remote_number_trivia_repository.dart';
import 'package:flutter_experiments/src/number_trivia/domain/bloc.dart';
import 'package:flutter_experiments/src/number_trivia/domain/number_trivia_service.dart';
import 'package:flutter_experiments/src/util/input_converter.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'number_trivia/data_management/number_trivia.dart';

final injector = GetIt.instance;

class FakeNetworkInfo implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

Future<void> init() async {
  injector.registerLazySingleton(
    () => http.Client(),
  );

  injector.registerLazySingleton(
    () => NumberTriviaRemoteDataSource(client: injector.get()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(
    () => sharedPreferences,
  );

  injector.registerLazySingleton(
    () => NumberTriviaLocalDataSource(sharedPreferences: injector.get()),
  );

  injector.registerLazySingleton(
    () => DataConnectionChecker(),
  );

  injector.registerLazySingleton<NetworkInfo>(
    () => FakeNetworkInfo(), //NetworkInfo(connectionChecker: injector.get()),
  );

  injector.registerLazySingleton<NumberTriviaRepository>(
    () => RemoteNumberTriviaRepository(
      remoteDataSource: injector.get(),
      localDataSource: injector.get(),
      networkInfo: injector.get(),
    ),
  );

  injector.registerLazySingleton(
    () => NumberTriviaService(numberTriviaRepository: injector.get()),
  );

  injector.registerLazySingleton(
    () => InputConverter(),
  );

  injector.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      numberTriviaService: injector.get(),
      inputConverter: injector.get(),
    ),
  );
}
