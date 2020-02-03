import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';

class NetworkInfo {
  DataConnectionChecker connectionChecker;

  NetworkInfo({@required this.connectionChecker});

  Future<bool> get isConnected => connectionChecker.hasConnection;
}
