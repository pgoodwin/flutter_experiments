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

final injector = GetIt.instance;

Future<void> init() async {
  injector.registerSingleton(http.Client());

  injector.registerSingleton(NumberTriviaRemoteDataSource(
    client: injector.get()
  ));

  injector.registerLazySingleton(() async => await SharedPreferences.getInstance());

  injector.registerSingleton(NumberTriviaLocalDataSource(
    sharedPreferences: injector.get()
  ));

  injector.registerSingleton(DataConnectionChecker());

  injector.registerSingleton(NetworkInfo(
    connectionChecker: injector.get()
  ));

  injector.registerSingleton(RemoteNumberTriviaRepository(
    remoteDataSource: injector.get(),
    localDataSource: injector.get(),
    networkInfo: injector.get()
  ));

  injector.registerSingleton(NumberTriviaService(
    numberTriviaRepository: injector.get()
  ));

  injector.registerSingleton(InputConverter());

  injector.registerFactory(() => NumberTriviaBloc(
    numberTriviaService: injector.get(),
    inputConverter: injector.get(),
  ));
}
