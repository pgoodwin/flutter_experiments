import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_experiments/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfo subject;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();

    subject = NetworkInfo(connectionChecker: mockDataConnectionChecker);
  });

  group('isConnected', () {
    final expectedHasConnectionResult = Future.value(true);
    setUp(() {
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => expectedHasConnectionResult);
    });

    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      final result = subject.isConnected;

      expect(result, expectedHasConnectionResult);
    });
  });
}
