import 'package:flutter_test/flutter_test.dart';
import 'package:magento_api_client/magento_api_client.dart';

void main() {
  group('NetworkClient', () {
    test('should be a singleton', () {
      final client1 = NetworkClient.instance;
      final client2 = NetworkClient.instance;
      expect(client1, equals(client2));
    });
  });
}
