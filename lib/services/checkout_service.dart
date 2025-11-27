import 'package:magento_api_client/models/checkout.dart';
import 'package:magento_api_client/models/country.dart';

import '../api/api_client.dart';
import '../constants/api_endpoints.dart';

/// Checkout service that handles directory lookups and guest checkout flows.
class CheckoutService {
  CheckoutService();

  final NetworkClient _client = NetworkClient.instance;

  /// Fetch a list of supported countries.
  Future<List<MagentoCountryItem>> getCountries() async {
    final response = await _client.get(
      ApiEndpoints.countries,
      requiresAuth: false,
    );
    if (response is List) {
      return response
          .map((x) => MagentoCountryItem.fromJson(x as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Estimate shipping methods for a guest cart.
  ///
  /// The [address] map should match Magento's expected schema, e.g.
  /// {
  ///   "region": "New York",
  ///   "region_id": 43,
  ///   "country_id": "US",
  ///   "postcode": "10001",
  ///   "city": "New York",
  ///   "street": ["123 Main St"],
  ///   "telephone": "1234567890"
  /// }
  Future<List<MagentoShippingMethod>> estimateGuestShippingMethods({
    required String cartId,
    required Map<String, dynamic> address,
  }) async {
    final response = await _client.post(
      ApiEndpoints.guestCartEstimateShipping(cartId),
      body: {'address': address},
      requiresAuth: false,
    );
    if (response is List) {
      return response
          .map((x) => MagentoShippingMethod.fromJson(x as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Submit shipping information for a guest cart.
  ///
  /// The [addressInformation] map should include `shipping_address`,
  /// `billing_address`, `shipping_carrier_code`, and `shipping_method_code`.
  Future<Map<String, dynamic>> setGuestShippingInformation({
    required String cartId,
    required MagentoShippingInformationInput addressInformation,
  }) async {
    final response = await _client.post(
      ApiEndpoints.guestCartShippingInformation(cartId),
      body: addressInformation.toJson(),
      requiresAuth: false,
    );

    if (response is Map<String, dynamic>) {
      return response;
    }
    return {'data': response};
  }

  /// Get payment methods available for a guest cart.
  Future<List<MagentoPaymentMethod>> getGuestPaymentMethods(
    String cartId,
  ) async {
    final response = await _client.get(
      ApiEndpoints.guestCartPaymentMethods(cartId),
      requiresAuth: false,
    );

    if (response is List) {
      return response
          .map((x) => MagentoPaymentMethod.fromJson(x as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Place a guest order by submitting payment information.
  ///
  /// The [paymentMethod] map should contain `method` and optionally
  /// `additional_data`. The optional [billingAddress] can be provided if
  /// different from the shipping address submitted earlier.
  Future<String> placeGuestOrder({
    required String cartId,
    required MagentoPaymentInformationInput paymentInfo,
  }) async {
    final response = await _client.post(
      ApiEndpoints.guestCartPaymentInformation(cartId),
      body: paymentInfo.toJson(),
      requiresAuth: false,
    );

    return response.toString();
  }
}
