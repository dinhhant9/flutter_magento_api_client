import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_keys.dart';

/// Manages local storage for Magento API client
class StorageManager {
  static SharedPreferences? _prefs;
  
  /// Initialize storage manager
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
  
  /// Save user token
  static Future<bool> saveUserToken(String token) async {
    await init();
    return await _prefs!.setString(StorageKeys.userToken, token);
  }
  
  /// Get user token
  static Future<String?> getUserToken() async {
    await init();
    return _prefs!.getString(StorageKeys.userToken);
  }
  
  /// Remove user token
  static Future<bool> removeUserToken() async {
    await init();
    return await _prefs!.remove(StorageKeys.userToken);
  }
  
  /// Save customer ID
  static Future<bool> saveCustomerId(int customerId) async {
    await init();
    return await _prefs!.setInt(StorageKeys.customerId, customerId);
  }
  
  /// Get customer ID
  static Future<int?> getCustomerId() async {
    await init();
    return _prefs!.getInt(StorageKeys.customerId);
  }
  
  /// Remove customer ID
  static Future<bool> removeCustomerId() async {
    await init();
    return await _prefs!.remove(StorageKeys.customerId);
  }
  
  /// Save customer email
  static Future<bool> saveCustomerEmail(String email) async {
    await init();
    return await _prefs!.setString(StorageKeys.customerEmail, email);
  }
  
  /// Get customer email
  static Future<String?> getCustomerEmail() async {
    await init();
    return _prefs!.getString(StorageKeys.customerEmail);
  }
  
  /// Remove customer email
  static Future<bool> removeCustomerEmail() async {
    await init();
    return await _prefs!.remove(StorageKeys.customerEmail);
  }
  
  /// Save cart ID
  static Future<bool> saveCartId(String cartId) async {
    await init();
    return await _prefs!.setString(StorageKeys.cartId, cartId);
  }
  
  /// Get cart ID
  static Future<String?> getCartId() async {
    await init();
    return _prefs!.getString(StorageKeys.cartId);
  }
  
  /// Remove cart ID
  static Future<bool> removeCartId() async {
    await init();
    return await _prefs!.remove(StorageKeys.cartId);
  }
  
  /// Save guest cart ID
  static Future<bool> saveGuestCartId(String cartId) async {
    await init();
    return await _prefs!.setString(StorageKeys.guestCartId, cartId);
  }
  
  /// Get guest cart ID
  static Future<String?> getGuestCartId() async {
    await init();
    return _prefs!.getString(StorageKeys.guestCartId);
  }
  
  /// Remove guest cart ID
  static Future<bool> removeGuestCartId() async {
    await init();
    return await _prefs!.remove(StorageKeys.guestCartId);
  }
  
  /// Clear all stored data
  static Future<bool> clearAll() async {
    await init();
    return await _prefs!.clear();
  }
}

