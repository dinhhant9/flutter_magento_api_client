# Magento API Client

A simple Flutter package for connecting to Magento REST API. This client supports OAuth1, Admin Token and Guest authentication, and exposes customer/product/cart/order/category/checkout APIs.

## Key features

- Multiple authentication methods: OAuth1, Admin Token, Guest
- Singleton client with a friendly API (factory + synchronous `instance` getter)
- Automatic token and session storage handling
- Full set of Magento APIs: customers, products, carts, orders, categories, checkout

## Installation

Add to your package's `pubspec.yaml`:

```yaml
dependencies:
  magento_api_client: ^0.0.1
```

Run:

```bash
flutter pub get
```

## Getting started

This library provides a single shared `MagentoApiClient` instance for your app. Initialize the client once (async), then access it synchronously anywhere in your code.

Example async initialization (recommended):

```dart
import 'package:magento_api_client/magento_api_client.dart';

final client = await MagentoApiClient.init(
  MagentoApiConfig(
    baseUrl: 'https://your-magento-store.com',
    authType: AuthType.adminToken,
    adminToken: 'your-admin-token',
  ),
);
```

Guest-only init helper:

```dart
final client = await MagentoApiClient.initGuest('https://your-magento-store.com');
```

Synchronous access after initialization

```dart
// Two equivalent ways to get the initialized singleton
final client1 = MagentoApiClient.instance; // throws StateError if init not called
final client2 = MagentoApiClient(); // factory that returns the singleton
```

Important: calling `MagentoApiClient.instance` or `MagentoApiClient()` before any call to `init(...)` will throw a `StateError`. Always call `await MagentoApiClient.init(...)` (or `initGuest`) during app startup before using synchronous access.

## Usage highlights

Authentication

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

Products

```dart
final products = await client.getProducts(pageSize: 20);
final product = await client.getProductBySku('SKU-12345');
```

Cart

```dart
final cartId = await client.createGuestCart();
await client.addItemToGuestCart(sku: 'SKU-12345', qty: 2, cartId: cartId);
final cart = await client.getCurrentCart();
```

Orders, categories and checkout APIs follow the same pattern (see API Reference below).

## Example app

See the `example/` directory for a small Flutter app demonstrating initialization and basic usage. Run it with:

```bash
cd example
flutter run
```

## API Reference (selected)

- Initialization: `init`, `initGuest`
- Synchronous access: `MagentoApiClient.instance` (throws if not initialized), `MagentoApiClient()` factory
- Authentication: `login`, `signUp`, `changePassword`, `resetPassword`, `logout`, `isLoggedIn`, `currentCustomer`
- Products: `getProducts`, `searchProducts`, `getProductBySku`, `getProductsByCategoryId`
- Cart: `createGuestCart`, `getGuestCart`, `getCurrentCart`, `addItemToCart`, `addItemToGuestCart`, `updateCustomerCartItem`, `removeCustomerCartItem`

For full API, consult the Dart docs or the source in `lib/`.

## Error handling

The package surfaces `ApiException` for API errors. Example:

```dart
try {
  await client.login('email@example.com', 'password');
} on ApiException catch (e) {
  print('API error: ${e.message}');
} catch (e) {
  print('Unexpected: $e');
}
```

Also note: accessing `MagentoApiClient.instance` or `MagentoApiClient()` before calling `init(...)` will throw `StateError` with guidance to call `init` first.

## Contributing

Contributions welcome. Open a PR or issue on GitHub.

## License

MIT. See LICENSE.
