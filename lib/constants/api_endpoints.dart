/// API endpoints constants for Magento REST API
class ApiEndpoints {
  // Base endpoints
  static const String customers = '/rest/default/V1/customers';
  static const String customerMe = '/rest/default/V1/customers/me';
  static const String customerToken = '/rest/default/V1/customers/login';
  static const String customerCreate = '/rest/default/V1/customers';
  static const String customerPassword = '/rest/default/V1/customers/password';
  static const String customerResetPassword = '/rest/default/V1/customers/resetPassword';
  
  // Products
  static const String products = '/rest/default/V1/products';
  static String productBySku(String sku) => '/rest/default/V1/products/$sku';
  
  // Categories
  static const String categories = '/rest/default/V1/categories';
  static String categoryById(int id) => '/rest/default/V1/categories/$id';
  
  // Cart
  static const String guestCarts = '/rest/default/V1/guest-carts';
  static String guestCart(String cartId) => '/rest/default/V1/guest-carts/$cartId';
  static String guestCartItems(String cartId) => '/rest/default/V1/guest-carts/$cartId/items';
  static String guestCartItem(String cartId, int itemId) => '/rest/default/V1/guest-carts/$cartId/items/$itemId';
  
  static const String carts = '/rest/default/V1/carts';
  static String cartMine = '/rest/default/V1/carts/mine';
  static String cartItems(String cartId) => '/rest/default/V1/carts/$cartId/items';
  static String cartItem(String cartId, int itemId) => '/rest/default/V1/carts/$cartId/items/$itemId';
  
  // Orders
  static const String orders = '/rest/default/V1/orders';
  static String orderById(int orderId) => '/rest/default/V1/orders/$orderId';
  static String orderMine = '/rest/default/V1/orders/mine';
  
  // Search
  static const String search = '/rest/default/V1/search';
  
  // Store
  static const String storeConfig = '/rest/default/V1/store/storeConfigs';
  static const String storeViews = '/rest/default/V1/store/storeViews';
  
  // Directory
  static const String countries = '/rest/default/V1/directory/countries';
  static const String currencies = '/rest/default/V1/directory/currency';
}

