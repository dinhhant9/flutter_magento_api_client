import '../api/api_client.dart';
import '../constants/api_endpoints.dart';
import '../models/customer.dart';
import '../storage/storage_manager.dart';

/// Service for customer-related operations
class CustomerService {
  final MagentoApiClient _client = MagentoApiClient.instance;

  /// Customer login
  Future<String> login(String email, String password) async {
    final response = await _client.post(
      ApiEndpoints.customerToken,
      body: {
        'username': email,
        'password': password,
      },
      requiresAuth: false,
    );

    final token = response.toString();
    await _client.setCustomerToken(token);
    
    // Get customer info and save
    final customer = await getCurrentCustomer();
    if (customer?.id != null) {
      await StorageManager.saveCustomerId(customer!.id!);
    }
    if (customer?.email != null) {
      await StorageManager.saveCustomerEmail(customer!.email!);
    }

    return token;
  }

  /// Customer sign up
  Future<Customer> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? prefix,
    String? suffix,
  }) async {
    final response = await _client.post(
      ApiEndpoints.customerCreate,
      body: {
        'customer': {
          'email': email,
          'firstname': firstName,
          'lastname': lastName,
          if (middleName != null) 'middlename': middleName,
          if (prefix != null) 'prefix': prefix,
          if (suffix != null) 'suffix': suffix,
        },
        'password': password,
      },
      requiresAuth: false,
    );

    final customer = Customer.fromJson(response);
    
    // Auto login after signup
    if (customer.email != null) {
      await login(email, password);
    }

    return customer;
  }

  /// Get current customer information
  Future<Customer?> getCurrentCustomer() async {
    try {
      final response = await _client.get(ApiEndpoints.customerMe);
      return Customer.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get customer by ID
  Future<Customer> getCustomerById(int customerId) async {
    final response = await _client.get('${ApiEndpoints.customers}/$customerId');
    return Customer.fromJson(response);
  }

  /// Update customer information
  Future<Customer> updateCustomer(Customer customer) async {
    final customerId = await StorageManager.getCustomerId();
    if (customerId == null) {
      throw Exception('Customer ID not found. Please login first.');
    }

    final response = await _client.put(
      '${ApiEndpoints.customers}/$customerId',
      body: customer.toJson(),
    );

    return Customer.fromJson(response);
  }

  /// Change customer password
  Future<bool> changePassword(String currentPassword, String newPassword) async {
    final customerId = await StorageManager.getCustomerId();
    if (customerId == null) {
      throw Exception('Customer ID not found. Please login first.');
    }

    await _client.put(
      ApiEndpoints.customerPassword,
      body: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );

    return true;
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    await _client.put(
      ApiEndpoints.customerResetPassword,
      body: {
        'email': email,
        'template': 'reset_password',
        'websiteId': 1,
      },
      requiresAuth: false,
    );

    return true;
  }

  /// Logout
  Future<void> logout() async {
    await _client.clearCustomerToken();
    await StorageManager.clearAll();
  }

  /// Check if customer is logged in
  Future<bool> isLoggedIn() async {
    final token = await _client.getCustomerToken();
    return token != null && token.isNotEmpty;
  }
}

