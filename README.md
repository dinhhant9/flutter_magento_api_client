# Magento API Client

A comprehensive Flutter package for connecting to Magento REST API with support for OAuth1, Admin Token, and Guest authentication. This package provides all the necessary APIs for building e-commerce applications with Magento.

## Features

- ✅ **Multiple Authentication Methods**: Support for OAuth1, Admin Token, and Guest access
- ✅ **Singleton Pattern**: Easy-to-use singleton client instance
- ✅ **Automatic Token Management**: Package automatically manages user tokens and storage
- ✅ **Complete E-commerce APIs**: Customer, Product, Cart, Order, and Category services
- ✅ **Type-Safe Models**: Full Dart models for all Magento entities
- ✅ **Error Handling**: Comprehensive error handling with custom exceptions
- ✅ **Storage Management**: Built-in storage for tokens and cart IDs

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  magento_api_client: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Getting Started

Create a single `MagentoApiClient` instance and keep it for the lifetime of your app.

```dart
import 'package:magento_api_client/magento_api_client.dart';

final client = await MagentoApiClient.init(
  MagentoApiConfig(
    baseUrl: 'https://your-magento-store.com',
    authType: AuthType.adminToken,
    adminToken: 'your-admin-token-here',
  ),
);
```

Need guest access only?

```dart
final client = await MagentoApiClient.initGuest(
  'https://your-magento-store.com',
);
```

OAuth1 is also supported:

```dart
final client = await MagentoApiClient.init(
  MagentoApiConfig(
    baseUrl: 'https://your-magento-store.com',
    authType: AuthType.oauth1,
    oauthConsumerKey: 'your-consumer-key',
    oauthConsumerSecret: 'your-consumer-secret',
    oauthToken: 'your-oauth-token',
    oauthTokenSecret: 'your-oauth-token-secret',
  ),
);
```

## Usage (All with `MagentoApiClient`)

### Authentication

```dart
await client.login('customer@example.com', 'password123');
print('Current customer: ${client.currentCustomer?.email}');

await client.signUp(
  email: 'newcustomer@example.com',
  password: 'securePassword123',
  firstName: 'John',
  lastName: 'Doe',
);

await client.changePassword('oldPass', 'newPass');
await client.logout();
```

### Products

```dart
final products = await client.getProducts(pageSize: 20, currentPage: 1);
final filtered = await client.getProducts(filters: {'status': 1});
final search = await client.searchProducts(searchTerm: 'laptop');
final byCategory = await client.getProductsByCategoryId(categoryId: 5);
final product = await client.getProductBySku('SKU-12345');
```

### Cart

Guest flow:

```dart
final cartId = await client.createGuestCart();
await client.addItemToGuestCart(sku: 'SKU-12345', qty: 2, cartId: cartId);
final guestCart = await client.getGuestCart(cartId);
```

Logged-in flow (or auto-detect with current cart):

```dart
await client.addItemToCart(sku: 'SKU-12345', qty: 1);
final cart = await client.getCurrentCart();
await client.updateCustomerCartItem(itemId: 12, qty: 3);
await client.removeCustomerCartItem(12);
```

### Orders

```dart
final myOrders = await client.getMyOrders(pageSize: 10);
final order = await client.getOrderById(123);
final allOrders = await client.getAllOrders(filters: {'status': 'processing'});
```

### Categories

```dart
final categories = await client.getCategories(pageSize: 50);
final category = await client.getCategoryById(5);
final tree = await client.getCategoryTree(rootCategoryId: 2, depth: 3);
```

### Checkout (Guest)

```dart
final countries = await client.getCountries();
final shippingMethods = await client.estimateGuestShippingMethods(
  cartId: 'guest_cart_id',
  address: {
    'country_id': 'US',
    'postcode': '10001',
    'city': 'New York',
    'street': ['123 Main Street'],
    'telephone': '123456789',
  },
);

await client.setGuestShippingInformation(
  cartId: 'guest_cart_id',
  addressInformation: {
    'shipping_address': {/* ... */},
    'billing_address': {/* ... */},
    'shipping_carrier_code': 'flatrate',
    'shipping_method_code': 'flatrate',
  },
);

final paymentMethods = await client.getGuestPaymentMethods('guest_cart_id');
final orderId = await client.placeGuestOrder(
  cartId: 'guest_cart_id',
  paymentMethod: {'method': 'checkmo'},
);
```

## Example App

The `example/` directory contains a small Flutter app that demonstrates how to:
- Initialize the client
- Login a customer
- Fetch products
- Add an item to the cart

To run the example:

```bash
cd example
flutter run
```

## API Reference

`MagentoApiClient` exposes every Magento REST feature through intuitive methods.

- **Initialization**: `init`, `initGuest`
- **Authentication**: `login`, `signUp`, `changePassword`, `resetPassword`, `logout`, `isLoggedIn`, `currentCustomer`
- **Products**: `getProducts`, `searchProducts`, `getProductBySku`, `getProductsByCategoryId`
- **Cart**: All guest/customer helpers such as `createGuestCart`, `getCurrentCart`, `addItemToCart`, `addItemToGuestCart`, `updateCustomerCartItem`, etc.
- **Orders**: `getMyOrders`, `getOrderById`, `getAllOrders`
- **Categories**: `getCategories`, `getCategoryById`, `getCategoryTree`
- **Checkout**: `getCountries`, `estimateGuestShippingMethods`, `setGuestShippingInformation`, `getGuestPaymentMethods`, `placeGuestOrder`

Models (`Customer`, `Product`, `Cart`, `Order`, `Category`) are returned by these methods so you can work with strongly typed data throughout your app.

## Error Handling

The package uses custom exceptions for better error handling:

```dart
import 'package:magento_api_client/magento_api_client.dart';

try {
  await customerService.login('email@example.com', 'password');
} on ApiException catch (e) {
  print('API Error: ${e.message}');
  print('Status Code: ${e.statusCode}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## Storage

The package automatically manages storage for:
- User tokens
- Customer IDs
- Customer emails
- Cart IDs (both guest and customer)

All storage is handled internally using `shared_preferences`. You don't need to manually manage tokens - the package handles everything automatically.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or contributions, please visit the [GitHub repository](https://github.com/dinhhant9/flutter_magento_api_client).

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.
