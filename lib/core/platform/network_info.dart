import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';

class NetworkInfo {
  DataConnectionChecker _connectionChecker;

  NetworkInfo({@required DataConnectionChecker connectionChecker}) {
    this._connectionChecker = connectionChecker;
  }

  Future<bool> get isConnected => _connectionChecker.hasConnection;
}
