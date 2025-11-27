import '../api/api_client.dart';
import '../constants/api_endpoints.dart';
import '../models/cart.dart';
import '../storage/storage_manager.dart';

/// Service for cart-related operations
class CartService {
  final NetworkClient _client = NetworkClient.instance;

  /// Create guest cart
  Future<String> createGuestCart() async {
    final response = await _client.post(
      ApiEndpoints.guestCarts,
      requiresAuth: false,
    );

    final cartId = response.toString().replaceAll('"', '');
    await StorageManager.saveGuestCartId(cartId);
    return cartId;
  }

  /// Get guest cart
  Future<MagentoCart> getGuestCart([String? cartId]) async {
    final id = cartId ?? await StorageManager.getGuestCartId();
    if (id == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    final response = await _client.get(
      ApiEndpoints.guestCart(id),
      requiresAuth: false,
    );

    return MagentoCart.fromJson(response);
  }

  /// Add item to guest cart
  Future<MagentoCartItem> addItemToGuestCart({
    required String sku,
    required int qty,
    String? cartId,
  }) async {
    final id = cartId ?? await StorageManager.getGuestCartId();
    if (id == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    final response = await _client.post(
      ApiEndpoints.guestCartItems(id),
      body: {
        'cartItem': {
          'sku': sku,
          'qty': qty,
        },
      },
      requiresAuth: false,
    );

    return MagentoCartItem.fromJson(response);
  }

  /// Update item in guest cart
  Future<MagentoCartItem> updateGuestCartItem({
    required int itemId,
    required int qty,
    String? cartId,
  }) async {
    final id = cartId ?? await StorageManager.getGuestCartId();
    if (id == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    final response = await _client.put(
      ApiEndpoints.guestCartItem(id, itemId),
      body: {
        'cartItem': {
          'item_id': itemId,
          'qty': qty,
        },
      },
      requiresAuth: false,
    );

    return MagentoCartItem.fromJson(response);
  }

  /// Remove item from guest cart
  Future<bool> removeGuestCartItem({
    required int itemId,
    String? cartId,
  }) async {
    final id = cartId ?? await StorageManager.getGuestCartId();
    if (id == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    await _client.delete(
      ApiEndpoints.guestCartItem(id, itemId),
      requiresAuth: false,
    );

    return true;
  }

  /// Get customer cart (for logged-in users)
  Future<MagentoCart> getCustomerCart() async {
    final response = await _client.get(ApiEndpoints.cartMine);
    final cart = MagentoCart.fromJson(response);
    
    if (cart.id != null) {
      await StorageManager.saveCartId(cart.id.toString());
    }

    return cart;
  }

  /// Create customer cart
  Future<MagentoCart> createCustomerCart() async {
    final response = await _client.post(ApiEndpoints.carts);
    final cart = MagentoCart.fromJson(response);
    
    if (cart.id != null) {
      await StorageManager.saveCartId(cart.id.toString());
    }

    return cart;
  }

  /// Add item to customer cart
  Future<MagentoCartItem> addItemToCustomerCart({
    required String sku,
    required int qty,
  }) async {
    final response = await _client.post(
      '${ApiEndpoints.cartMine}/items',
      body: {
        'cartItem': {
          'sku': sku,
          'qty': qty,
        },
      },
    );

    return MagentoCartItem.fromJson(response);
  }

  /// Update item in customer cart
  Future<MagentoCartItem> updateCustomerCartItem({
    required int itemId,
    required int qty,
  }) async {
    final cartId = await StorageManager.getCartId();
    if (cartId == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    final response = await _client.put(
      ApiEndpoints.cartItem(cartId, itemId),
      body: {
        'cartItem': {
          'item_id': itemId,
          'qty': qty,
        },
      },
    );

    return MagentoCartItem.fromJson(response);
  }

  /// Remove item from customer cart
  Future<bool> removeCustomerCartItem(int itemId) async {
    final cartId = await StorageManager.getCartId();
    if (cartId == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    await _client.delete(ApiEndpoints.cartItem(cartId, itemId));
    return true;
  }

  /// Get current cart (automatically detects guest or customer)
  Future<MagentoCart> getCurrentCart() async {
    final isLoggedIn = await _client.getCustomerToken() != null;
    
    if (isLoggedIn) {
      return getCustomerCart();
    }
    return getGuestCart();
  }

  /// Add item to current cart (automatically detects guest or customer)
  Future<MagentoCartItem> addItemToCurrentCart({
    required String sku,
    required int qty,
  }) async {
    final isLoggedIn = await _client.getCustomerToken() != null;
    
    if (isLoggedIn) {
      return addItemToCustomerCart(sku: sku, qty: qty);
    } else {
      // Ensure guest cart exists
      var cartId = await StorageManager.getGuestCartId();
      if (cartId == null) {
        cartId = await createGuestCart();
      }
      return addItemToGuestCart(sku: sku, qty: qty, cartId: cartId);
    }
  }
}

