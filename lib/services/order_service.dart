import '../api/api_client.dart';
import '../constants/api_endpoints.dart';
import '../models/order.dart';

/// Service for order-related operations
class OrderService {
  final NetworkClient _client = NetworkClient.instance;

  /// Get orders for current customer
  Future<List<Order>> getMyOrders({
    int? pageSize,
    int? currentPage,
  }) async {
    final queryParams = <String, String>{};

    if (pageSize != null) {
      queryParams['searchCriteria[pageSize]'] = pageSize.toString();
    }
    if (currentPage != null) {
      queryParams['searchCriteria[currentPage]'] = currentPage.toString();
    }

    final response = await _client.get(
      ApiEndpoints.orderMine,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    if (response is Map && response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Order.fromJson(item))
          .toList();
    }

    return [];
  }

  /// Get order by ID
  Future<Order> getOrderById(int orderId) async {
    final response = await _client.get(ApiEndpoints.orderById(orderId));
    return Order.fromJson(response);
  }

  /// Get all orders (requires admin access)
  Future<List<Order>> getAllOrders({
    int? pageSize,
    int? currentPage,
    Map<String, dynamic>? filters,
  }) async {
    final queryParams = <String, String>{};

    if (pageSize != null) {
      queryParams['searchCriteria[pageSize]'] = pageSize.toString();
    }
    if (currentPage != null) {
      queryParams['searchCriteria[currentPage]'] = currentPage.toString();
    }

    // Add filters
    if (filters != null && filters.isNotEmpty) {
      int index = 0;
      filters.forEach((key, value) {
        queryParams['searchCriteria[filterGroups][0][filters][$index][field]'] = key;
        queryParams['searchCriteria[filterGroups][0][filters][$index][value]'] = value.toString();
        queryParams['searchCriteria[filterGroups][0][filters][$index][conditionType]'] = 'eq';
        index++;
      });
    }

    final response = await _client.get(
      ApiEndpoints.orders,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    if (response is Map && response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Order.fromJson(item))
          .toList();
    }

    return [];
  }
}

