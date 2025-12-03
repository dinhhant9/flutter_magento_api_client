import 'package:magento_api_client/models/checkout.dart';
import 'package:magento_api_client/models/country.dart';

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
  // Private internal constructor used to create the single shared instance.
  MagentoApiClient._internal();

  // The single shared instance of MagentoApiClient.
  static final MagentoApiClient _instance = MagentoApiClient._internal();

  // Public synchronous accessor for the singleton instance.
  /// Returns the initialized singleton instance.
  ///
  /// Throws a [StateError] if accessed before calling `MagentoApiClient.init(...)`.
  static MagentoApiClient get instance {
    if (!_instance._isInitialized) {
      throw StateError(
        'MagentoApiClient.instance called before init. Call MagentoApiClient.init(config) or MagentoApiClient.initGuest(baseUrl) first.',
      );
    }
    return _instance;
  }

  /// Factory constructor that returns the singleton instance.
  /// This provides a familiar API style: `var client = MagentoApiClient();`
  /// It will rethrow the same [StateError] as `instance` if not initialized.
  factory MagentoApiClient() => instance;

  bool _isInitialized = false;

  final CustomerService _customerService = CustomerService();
  final ProductService _productService = ProductService();
  final CartService _cartService = CartService();
  final OrderService _orderService = OrderService();
  final CategoryService _categoryService = CategoryService();
  final CheckoutService _checkoutService = CheckoutService();

  MagentoCustomer? _currentCustomer;
  MagentoCart? _currentCart;

  bool get isInitialized => _isInitialized;
  MagentoCustomer? get currentCustomer => _currentCustomer;
  MagentoCart? get currentCart => _currentCart;

  /// Initialize the underlying network client and return a ready-to-use facade.
  /// Initialize the underlying network client and return the singleton.
  ///
  /// Calling `init` multiple times is safe; initialization only runs once.
  static Future<MagentoApiClient> init(MagentoApiConfig config) async {
    if (!_instance._isInitialized) {
      await NetworkClient.init(config);
      _instance._isInitialized = true;
      await _instance._loadSessionData();
    }
    return _instance;
  }

  /// Convenience helper for guest-only initialization.
  static Future<MagentoApiClient> initGuest(String baseUrl) {
    return init(MagentoApiConfig(baseUrl: baseUrl, authType: AuthType.guest));
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
      final isLoggedIn = await _customerService.isLoggedIn();
      if (isLoggedIn) {
        _currentCustomer = await _customerService.getCurrentCustomer();
      }
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

  Future<MagentoCustomer> signUp({
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

  Future<MagentoCustomer?> fetchCurrentCustomer() async {
    _ensureInitialized();
    final customer = await _customerService.getCurrentCustomer();
    _currentCustomer = customer;
    return customer;
  }

  Future<MagentoCustomer> getCustomerById(int customerId) async {
    _ensureInitialized();
    return _customerService.getCustomerById(customerId);
  }

  Future<MagentoCustomer> updateCustomer(MagentoCustomer customer) async {
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

  Future<MagentoProductResult> getProducts({
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

  Future<MagentoProduct> getProductBySku(String sku) {
    _ensureInitialized();
    return _productService.getProductBySku(sku);
  }

  Future<List<MagentoProduct>> getProductsBySkus(List<String> skus) {
    _ensureInitialized();
    return _productService.getProductsBySkus(skus);
  }

  Future<List<MagentoProduct>> searchProducts({
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

  Future<List<MagentoProduct>> getProductsByCategoryId({
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

  Future<MagentoCart> getGuestCart([String? cartId]) {
    _ensureInitialized();
    return _cartService.getGuestCart(cartId);
  }

  Future<MagentoCartItem> addItemToGuestCart({
    required String sku,
    required int qty,
    String? cartId,
  }) {
    _ensureInitialized();
    return _cartService.addItemToGuestCart(sku: sku, qty: qty, cartId: cartId);
  }

  Future<MagentoCartItem> updateGuestCartItem({
    required int itemId,
    required int qty,
    String? cartId,
  }) {
    _ensureInitialized();
    return _cartService.updateGuestCartItem(
      itemId: itemId,
      qty: qty,
      cartId: cartId,
    );
  }

  Future<bool> removeGuestCartItem({required int itemId, String? cartId}) {
    _ensureInitialized();
    return _cartService.removeGuestCartItem(itemId: itemId, cartId: cartId);
  }

  Future<MagentoCart> getCustomerCart() async {
    _ensureInitialized();
    final cart = await _cartService.getCustomerCart();
    _currentCart = cart;
    return cart;
  }

  Future<MagentoCart> createCustomerCart() {
    _ensureInitialized();
    return _cartService.createCustomerCart();
  }

  Future<MagentoCartItem> addItemToCustomerCart({
    required String sku,
    required int qty,
  }) {
    _ensureInitialized();
    return _cartService.addItemToCustomerCart(sku: sku, qty: qty);
  }

  Future<MagentoCartItem> updateCustomerCartItem({
    required int itemId,
    required int qty,
  }) {
    _ensureInitialized();
    return _cartService.updateCustomerCartItem(itemId: itemId, qty: qty);
  }

  Future<bool> removeCustomerCartItem(int itemId) {
    _ensureInitialized();
    return _cartService.removeCustomerCartItem(itemId);
  }

  Future<MagentoCart> getCurrentCart() async {
    _ensureInitialized();
    final cart = await _cartService.getCurrentCart();
    _currentCart = cart;
    return cart;
  }

  Future<MagentoCartItem> addItemToCurrentCart({
    required String sku,
    required int qty,
  }) async {
    _ensureInitialized();
    final item = await _cartService.addItemToCurrentCart(sku: sku, qty: qty);
    try {
      _currentCart = await _cartService.getCurrentCart();
    } catch (_) {}
    return item;
  }

  Future<MagentoCartItem> addItemToCart({
    required String sku,
    required int qty,
  }) {
    return addItemToCurrentCart(sku: sku, qty: qty);
  }

  // ---------------------------------------------------------------------------
  // Order APIs
  // ---------------------------------------------------------------------------

  Future<List<MagentoOrder>> getMyOrders({int? pageSize, int? currentPage}) {
    _ensureInitialized();
    return _orderService.getMyOrders(
      pageSize: pageSize,
      currentPage: currentPage,
    );
  }

  Future<MagentoOrder> getOrderById(int orderId) {
    _ensureInitialized();
    return _orderService.getOrderById(orderId);
  }

  Future<List<MagentoOrder>> getAllOrders({
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

  Future<MagentoCategory> getCategories({int? pageSize, int? currentPage}) {
    _ensureInitialized();
    return _categoryService.getCategories(
      pageSize: pageSize,
      currentPage: currentPage,
    );
  }

  Future<MagentoCategory> getCategoryById(int categoryId) {
    _ensureInitialized();
    return _categoryService.getCategoryById(categoryId);
  }

  Future<MagentoCategory> getCategoryTree({int? rootCategoryId, int? depth}) {
    _ensureInitialized();
    return _categoryService.getCategoryTree(
      rootCategoryId: rootCategoryId,
      depth: depth,
    );
  }

  // ---------------------------------------------------------------------------
  // Checkout APIs
  // ---------------------------------------------------------------------------

  Future<List<MagentoCountryItem>> getCountries() {
    _ensureInitialized();
    return _checkoutService.getCountries();
  }

  Future<List<MagentoShippingMethod>> estimateGuestShippingMethods({
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
    required MagentoShippingInformationInput addressInformation,
  }) {
    _ensureInitialized();
    return _checkoutService.setGuestShippingInformation(
      cartId: cartId,
      addressInformation: addressInformation,
    );
  }

  Future<List<MagentoPaymentMethod>> getGuestPaymentMethods(String cartId) {
    _ensureInitialized();
    return _checkoutService.getGuestPaymentMethods(cartId);
  }

  Future<String> placeGuestOrder({
    required String cartId,
    required MagentoPaymentInformationInput paymentInfo,
  }) {
    _ensureInitialized();
    return _checkoutService.placeGuestOrder(
      cartId: cartId,
      paymentInfo: paymentInfo,
    );
  }
}
