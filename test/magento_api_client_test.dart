import 'package:flutter_test/flutter_test.dart';
import 'package:magento_api_client/magento_api_client.dart';

void main() {
  group('MagentoApiClient', () {
    test('should be a singleton', () {
      final client1 = MagentoApiClient.instance;
      final client2 = MagentoApiClient.instance;
      expect(client1, equals(client2));
    });
  });
}
