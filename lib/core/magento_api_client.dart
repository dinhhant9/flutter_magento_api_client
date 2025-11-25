import '../api/api_client.dart';
import '../api/auth_type.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/customer.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../services/category_service.dart';
import '../services/checkout_service.dart';
import '../services/customer_service.dart';
import '../services/order_service.dart';
import '../services/product_service.dart';

/// High-level facade that bundles every Magento service into a single class.
class MagentoApiClient {
  MagentoApiClient._();

  bool _isInitialized = false;

  final CustomerService _customerService = CustomerService();
  final ProductService _productService = ProductService();
  final CartService _cartService = CartService();
  final OrderService _orderService = OrderService();
  final CategoryService _categoryService = CategoryService();
  final CheckoutService _checkoutService = CheckoutService();

  Customer? _currentCustomer;
  Cart? _currentCart;

  bool get isInitialized => _isInitialized;
  Customer? get currentCustomer => _currentCustomer;
  Cart? get currentCart => _currentCart;

  /// Initialize the underlying network client and return a ready-to-use facade.
  static Future<MagentoApiClient> init(MagentoApiConfig config) async {
    await NetworkClient.init(config);
    final client = MagentoApiClient._();
    client._isInitialized = true;
    await client._loadSessionData();
    return client;
  }

  /// Convenience helper for guest-only initialization.
  static Future<MagentoApiClient> initGuest(String baseUrl) {
    return init(
      MagentoApiConfig(baseUrl: baseUrl, authType: AuthType.guest),
    );
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'MagentoApiClient has not been initialized. Call MagentoApiClient.init() first.',
      );
    }
  }

  Future<void> _loadSessionData() async {
    try {
      _currentCustomer = await _customerService.getCurrentCustomer();
    } catch (_) {
      _currentCustomer = null;
    }

    try {
      _currentCart = await _cartService.getCurrentCart();
    } catch (_) {
      _currentCart = null;
    }
  }

  // ---------------------------------------------------------------------------
  // Customer APIs
  // ---------------------------------------------------------------------------

  Future<String> login(String email, String password) async {
    _ensureInitialized();
    final token = await _customerService.login(email, password);
    await _loadSessionData();
    return token;
  }

  Future<Customer> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? prefix,
    String? suffix,
  }) async {
    _ensureInitialized();
    final customer = await _customerService.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      prefix: prefix,
      suffix: suffix,
    );
    await _loadSessionData();
    return customer;
  }

  Future<Customer?> fetchCurrentCustomer() async {
    _ensureInitialized();
    final customer = await _customerService.getCurrentCustomer();
    _currentCustomer = customer;
    return customer;
  }

  Future<Customer> getCustomerById(int customerId) async {
    _ensureInitialized();
    return _customerService.getCustomerById(customerId);
  }

  Future<Customer> updateCustomer(Customer customer) async {
    _ensureInitialized();
    final updated = await _customerService.updateCustomer(customer);
    _currentCustomer = updated;
    return updated;
  }

  Future<bool> changePassword(String currentPassword, String newPassword) {
    _ensureInitialized();
    return _customerService.changePassword(currentPassword, newPassword);
  }

  Future<bool> resetPassword(String email) {
    _ensureInitialized();
    return _customerService.resetPassword(email);
  }

  Future<void> logout() async {
    _ensureInitialized();
    await _customerService.logout();
    _currentCustomer = null;
    _currentCart = null;
  }

  Future<bool> isLoggedIn() {
    _ensureInitialized();
    return _customerService.isLoggedIn();
  }

  // ---------------------------------------------------------------------------
  // Product APIs
  // ---------------------------------------------------------------------------

  Future<List<Product>> getProducts({
    int? pageSize,
    int? currentPage,
    Map<String, dynamic>? filters,
    String? sortField,
    String? sortOrder,
  }) {
    _ensureInitialized();
    return _productService.getProducts(
      pageSize: pageSize,
      currentPage: currentPage,
      filters: filters,
      sortField: sortField,
      sortOrder: sortOrder,
    );
  }

  Future<List<Product>> fetchProducts({
    int? pageSize,
    int? currentPage,
    Map<String, dynamic>? filters,
    String? sortField,
    String? sortOrder,
  }) {
    return getProducts(
      pageSize: pageSize,
      currentPage: currentPage,
      filters: filters,
      sortField: sortField,
      sortOrder: sortOrder,
    );
  }

  Future<Product> getProductBySku(String sku) {
    _ensureInitialized();
    return _productService.getProductBySku(sku);
  }

  Future<List<Product>> searchProducts({
    required String searchTerm,
    int? pageSize,
    int? currentPage,
  }) {
    _ensureInitialized();
    return _productService.searchProducts(
      searchTerm: searchTerm,
      pageSize: pageSize,
      currentPage: currentPage,
    );
  }

  Future<List<Product>> getProductsByCategoryId({
    required int categoryId,
    int? pageSize,
    int? currentPage,
  }) {
    _ensureInitialized();
    return _productService.getProductsByCategoryId(
      categoryId: categoryId,
      pageSize: pageSize,
      currentPage: currentPage,
    );
  }

  // ---------------------------------------------------------------------------
  // Cart APIs
  // ---------------------------------------------------------------------------

  Future<String> createGuestCart() {
    _ensureInitialized();
    return _cartService.createGuestCart();
  }

  Future<Cart> getGuestCart([String? cartId]) {
    _ensureInitialized();
    return _cartService.getGuestCart(cartId);
  }

  Future<CartItem> addItemToGuestCart({
    required String sku,
    required double qty,
    String? cartId,
  }) {
    _ensureInitialized();
    return _cartService.addItemToGuestCart(
      sku: sku,
      qty: qty,
      cartId: cartId,
    );
  }

  Future<CartItem> updateGuestCartItem({
    required int itemId,
    required double qty,
    String? cartId,
  }) {
    _ensureInitialized();
    return _cartService.updateGuestCartItem(
      itemId: itemId,
      qty: qty,
      cartId: cartId,
    );
  }

  Future<bool> removeGuestCartItem({
    required int itemId,
    String? cartId,
  }) {
    _ensureInitialized();
    return _cartService.removeGuestCartItem(itemId: itemId, cartId: cartId);
  }

  Future<Cart> getCustomerCart() async {
    _ensureInitialized();
    final cart = await _cartService.getCustomerCart();
    _currentCart = cart;
    return cart;
  }

  Future<Cart> createCustomerCart() {
    _ensureInitialized();
    return _cartService.createCustomerCart();
  }

  Future<CartItem> addItemToCustomerCart({
    required String sku,
    required double qty,
  }) {
    _ensureInitialized();
    return _cartService.addItemToCustomerCart(sku: sku, qty: qty);
  }

  Future<CartItem> updateCustomerCartItem({
    required int itemId,
    required double qty,
  }) {
    _ensureInitialized();
    return _cartService.updateCustomerCartItem(itemId: itemId, qty: qty);
  }

  Future<bool> removeCustomerCartItem(int itemId) {
    _ensureInitialized();
    return _cartService.removeCustomerCartItem(itemId);
  }

  Future<Cart> getCurrentCart() async {
    _ensureInitialized();
    final cart = await _cartService.getCurrentCart();
    _currentCart = cart;
    return cart;
  }

  Future<CartItem> addItemToCurrentCart({
    required String sku,
    required double qty,
  }) async {
    _ensureInitialized();
    final item = await _cartService.addItemToCurrentCart(sku: sku, qty: qty);
    try {
      _currentCart = await _cartService.getCurrentCart();
    } catch (_) {}
    return item;
  }

  Future<CartItem> addItemToCart({
    required String sku,
    required double qty,
  }) {
    return addItemToCurrentCart(sku: sku, qty: qty);
  }

  // ---------------------------------------------------------------------------
  // Order APIs
  // ---------------------------------------------------------------------------

  Future<List<Order>> getMyOrders({int? pageSize, int? currentPage}) {
    _ensureInitialized();
    return _orderService.getMyOrders(
      pageSize: pageSize,
      currentPage: currentPage,
    );
  }

  Future<Order> getOrderById(int orderId) {
    _ensureInitialized();
    return _orderService.getOrderById(orderId);
  }

  Future<List<Order>> getAllOrders({
    int? pageSize,
    int? currentPage,
    Map<String, dynamic>? filters,
  }) {
    _ensureInitialized();
    return _orderService.getAllOrders(
      pageSize: pageSize,
      currentPage: currentPage,
      filters: filters,
    );
  }

  // ---------------------------------------------------------------------------
  // Category APIs
  // ---------------------------------------------------------------------------

  Future<List<Category>> getCategories({int? pageSize, int? currentPage}) {
    _ensureInitialized();
    return _categoryService.getCategories(
      pageSize: pageSize,
      currentPage: currentPage,
    );
  }

  Future<Category> getCategoryById(int categoryId) {
    _ensureInitialized();
    return _categoryService.getCategoryById(categoryId);
  }

  Future<Category> getCategoryTree({int? rootCategoryId, int? depth}) {
    _ensureInitialized();
    return _categoryService.getCategoryTree(
      rootCategoryId: rootCategoryId,
      depth: depth,
    );
  }

  // ---------------------------------------------------------------------------
  // Checkout APIs
  // ---------------------------------------------------------------------------

  Future<List<dynamic>> getCountries() {
    _ensureInitialized();
    return _checkoutService.getCountries();
  }

  Future<List<dynamic>> estimateGuestShippingMethods({
    required String cartId,
    required Map<String, dynamic> address,
  }) {
    _ensureInitialized();
    return _checkoutService.estimateGuestShippingMethods(
      cartId: cartId,
      address: address,
    );
  }

  Future<Map<String, dynamic>> setGuestShippingInformation({
    required String cartId,
    required Map<String, dynamic> addressInformation,
  }) {
    _ensureInitialized();
    return _checkoutService.setGuestShippingInformation(
      cartId: cartId,
      addressInformation: addressInformation,
    );
  }

  Future<List<dynamic>> getGuestPaymentMethods(String cartId) {
    _ensureInitialized();
    return _checkoutService.getGuestPaymentMethods(cartId);
  }

  Future<String> placeGuestOrder({
    required String cartId,
    required Map<String, dynamic> paymentMethod,
    Map<String, dynamic>? billingAddress,
  }) {
    _ensureInitialized();
    return _checkoutService.placeGuestOrder(
      cartId: cartId,
      paymentMethod: paymentMethod,
      billingAddress: billingAddress,
    );
  }
}


