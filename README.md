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

### Initialize the Client

Before using the package, you need to initialize the API client with your Magento store configuration.

#### Guest Access (No Authentication)

```dart
import 'package:magento_api_client/magento_api_client.dart';

await MagentoApiClient.init(
  MagentoApiConfig(
    baseUrl: 'https://your-magento-store.com',
    authType: AuthType.guest,
  ),
);
```

#### Admin Token Authentication

```dart
await MagentoApiClient.init(
  MagentoApiConfig(
    baseUrl: 'https://your-magento-store.com',
    authType: AuthType.adminToken,
    adminToken: 'your-admin-token-here',
  ),
);
```

#### OAuth1 Authentication

```dart
await MagentoApiClient.init(
  MagentoApiConfig(
    baseUrl: 'https://your-magento-store.com',
    authType: AuthType.oauth1,
    oauthConsumerKey: 'your-consumer-key',
    oauthConsumerSecret: 'your-consumer-secret',
    oauthToken: 'your-oauth-token', // Optional
    oauthTokenSecret: 'your-oauth-token-secret', // Optional
  ),
);
```

## Usage

### Customer Service

#### Login

```dart
final customerService = CustomerService();

try {
  final token = await customerService.login('customer@example.com', 'password');
  print('Login successful! Token: $token');
} catch (e) {
  print('Login failed: $e');
}
```

#### Sign Up

```dart
try {
  final customer = await customerService.signUp(
    email: 'newcustomer@example.com',
    password: 'securePassword123',
    firstName: 'John',
    lastName: 'Doe',
  );
  print('Sign up successful! Customer ID: ${customer.id}');
} catch (e) {
  print('Sign up failed: $e');
}
```

#### Get Current Customer

```dart
final customer = await customerService.getCurrentCustomer();
if (customer != null) {
  print('Customer: ${customer.firstName} ${customer.lastName}');
  print('Email: ${customer.email}');
}
```

#### Logout

```dart
await customerService.logout();
```

### Product Service

#### Get Products

```dart
final productService = ProductService();

// Get all products with pagination
final products = await productService.getProducts(
  pageSize: 20,
  currentPage: 1,
);

// Get products with filters
final filteredProducts = await productService.getProducts(
  filters: {
    'status': 1, // Only active products
    'visibility': 4, // Visible in catalog and search
  },
  pageSize: 10,
);

// Search products
final searchResults = await productService.searchProducts(
  searchTerm: 'laptop',
  pageSize: 20,
);

// Get products by category
final categoryProducts = await productService.getProductsByCategoryId(
  categoryId: 5,
  pageSize: 20,
);
```

#### Get Product by SKU

```dart
final product = await productService.getProductBySku('SKU-12345');
print('Product: ${product.name}');
print('Price: \$${product.price}');
```

### Cart Service

#### Guest Cart

```dart
final cartService = CartService();

// Create guest cart
final cartId = await cartService.createGuestCart();

// Add item to cart
final cartItem = await cartService.addItemToGuestCart(
  sku: 'SKU-12345',
  qty: 2,
  cartId: cartId,
);

// Get cart
final cart = await cartService.getGuestCart(cartId);
print('Cart total: \$${cart.grandTotal}');
print('Items: ${cart.itemsCount}');

// Update item quantity
await cartService.updateGuestCartItem(
  itemId: cartItem.itemId!,
  qty: 3,
  cartId: cartId,
);

// Remove item
await cartService.removeGuestCartItem(
  itemId: cartItem.itemId!,
  cartId: cartId,
);
```

#### Customer Cart (After Login)

```dart
// Add item to customer cart
final cartItem = await cartService.addItemToCustomerCart(
  sku: 'SKU-12345',
  qty: 1,
);

// Get customer cart
final cart = await cartService.getCustomerCart();

// Update item
await cartService.updateCustomerCartItem(
  itemId: cartItem.itemId!,
  qty: 2,
);

// Remove item
await cartService.removeCustomerCartItem(cartItem.itemId!);
```

#### Smart Cart Methods (Auto-detect Guest/Customer)

```dart
// Automatically uses guest or customer cart based on login status
final cart = await cartService.getCurrentCart();
final item = await cartService.addItemToCurrentCart(
  sku: 'SKU-12345',
  qty: 1,
);
```

### Order Service

#### Get My Orders

```dart
final orderService = OrderService();

// Get customer orders
final orders = await orderService.getMyOrders(
  pageSize: 10,
  currentPage: 1,
);

for (final order in orders) {
  print('Order #${order.incrementId}');
  print('Total: \$${order.grandTotal}');
  print('Status: ${order.status}');
}
```

#### Get Order by ID

```dart
final order = await orderService.getOrderById(123);
print('Order details: ${order.items?.length} items');
```

### Category Service

```dart
final categoryService = CategoryService();

// Get all categories
final categories = await categoryService.getCategories(
  pageSize: 50,
);

// Get category by ID
final category = await categoryService.getCategoryById(5);
print('Category: ${category.name}');

// Get category tree
final categoryTree = await categoryService.getCategoryTree(
  rootCategoryId: 2,
  depth: 3,
);
```

## API Reference

### MagentoApiClient

The main singleton client for making API requests.

#### Methods

- `static Future<void> init(MagentoApiConfig config)` - Initialize the client
- `Future<void> setCustomerToken(String token)` - Set customer token after login
- `Future<void> clearCustomerToken()` - Clear customer token (logout)
- `Future<String?> getCustomerToken()` - Get current customer token
- `Future<dynamic> get(String endpoint, ...)` - Make GET request
- `Future<dynamic> post(String endpoint, ...)` - Make POST request
- `Future<dynamic> put(String endpoint, ...)` - Make PUT request
- `Future<dynamic> delete(String endpoint, ...)` - Make DELETE request

### Services

- **CustomerService**: Customer authentication and management
- **ProductService**: Product listing and search
- **CartService**: Shopping cart operations
- **OrderService**: Order management
- **CategoryService**: Category operations

### Models

- **Customer**: Customer information and addresses
- **Product**: Product details
- **Cart**: Shopping cart with items
- **Order**: Order information
- **Category**: Category structure

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
