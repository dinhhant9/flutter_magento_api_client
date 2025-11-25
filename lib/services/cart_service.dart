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
  Future<Cart> getGuestCart([String? cartId]) async {
    final id = cartId ?? await StorageManager.getGuestCartId();
    if (id == null) {
      throw Exception('Cart ID not found. Please create a cart first.');
    }

    final response = await _client.get(
      ApiEndpoints.guestCart(id),
      requiresAuth: false,
    );

    return Cart.fromJson(response);
  }

  /// Add item to guest cart
  Future<CartItem> addItemToGuestCart({
    required String sku,
    required double qty,
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

    return CartItem.fromJson(response);
  }

  /// Update item in guest cart
  Future<CartItem> updateGuestCartItem({
    required int itemId,
    required double qty,
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

    return CartItem.fromJson(response);
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
  Future<Cart> getCustomerCart() async {
    final response = await _client.get(ApiEndpoints.cartMine);
    final cart = Cart.fromJson(response);
    
    if (cart.id != null) {
      await StorageManager.saveCartId(cart.id.toString());
    }

    return cart;
  }

  /// Create customer cart
  Future<Cart> createCustomerCart() async {
    final response = await _client.post(ApiEndpoints.carts);
    final cart = Cart.fromJson(response);
    
    if (cart.id != null) {
      await StorageManager.saveCartId(cart.id.toString());
    }

    return cart;
  }

  /// Add item to customer cart
  Future<CartItem> addItemToCustomerCart({
    required String sku,
    required double qty,
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

    return CartItem.fromJson(response);
  }

  /// Update item in customer cart
  Future<CartItem> updateCustomerCartItem({
    required int itemId,
    required double qty,
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

    return CartItem.fromJson(response);
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
  Future<Cart> getCurrentCart() async {
    final isLoggedIn = await _client.getCustomerToken() != null;
    
    if (isLoggedIn) {
      return getCustomerCart();
    }
    return getGuestCart();
  }

  /// Add item to current cart (automatically detects guest or customer)
  Future<CartItem> addItemToCurrentCart({
    required String sku,
    required double qty,
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

