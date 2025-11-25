import '../api/api_client.dart';
import '../constants/api_endpoints.dart';
import '../models/product.dart';

/// Service for product-related operations
class ProductService {
  final NetworkClient _client = NetworkClient.instance;

  /// Get products with pagination and filters
  Future<List<Product>> getProducts({
    int? pageSize,
    int? currentPage,
    Map<String, dynamic>? filters,
    String? sortField,
    String? sortOrder,
  }) async {
    final queryParams = <String, String>{};
    
    if (pageSize != null) {
      queryParams['searchCriteria[pageSize]'] = pageSize.toString();
    }
    if (currentPage != null) {
      queryParams['searchCriteria[currentPage]'] = currentPage.toString();
    }
    if (sortField != null) {
      queryParams['searchCriteria[sortOrders][0][field]'] = sortField;
      queryParams['searchCriteria[sortOrders][0][direction]'] = sortOrder ?? 'ASC';
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
      ApiEndpoints.products,
      queryParameters: queryParams,
      requiresAuth: false,
    );

    if (response is Map && response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }

    return [];
  }

  /// Get product by SKU
  Future<Product> getProductBySku(String sku) async {
    final response = await _client.get(
      ApiEndpoints.productBySku(sku),
      requiresAuth: false,
    );

    return Product.fromJson(response);
  }

  /// Search products
  Future<List<Product>> searchProducts({
    required String searchTerm,
    int? pageSize,
    int? currentPage,
  }) async {
    final queryParams = <String, String>{
      'searchCriteria[filterGroups][0][filters][0][field]': 'search_term',
      'searchCriteria[filterGroups][0][filters][0][value]': searchTerm,
      'searchCriteria[filterGroups][0][filters][0][conditionType]': 'like',
    };

    if (pageSize != null) {
      queryParams['searchCriteria[pageSize]'] = pageSize.toString();
    }
    if (currentPage != null) {
      queryParams['searchCriteria[currentPage]'] = currentPage.toString();
    }

    final response = await _client.get(
      ApiEndpoints.search,
      queryParameters: queryParams,
      requiresAuth: false,
    );

    if (response is Map && response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }

    return [];
  }

  /// Get products by category ID
  Future<List<Product>> getProductsByCategoryId({
    required int categoryId,
    int? pageSize,
    int? currentPage,
  }) async {
    final queryParams = <String, String>{
      'searchCriteria[filterGroups][0][filters][0][field]': 'category_id',
      'searchCriteria[filterGroups][0][filters][0][value]': categoryId.toString(),
      'searchCriteria[filterGroups][0][filters][0][conditionType]': 'eq',
    };

    if (pageSize != null) {
      queryParams['searchCriteria[pageSize]'] = pageSize.toString();
    }
    if (currentPage != null) {
      queryParams['searchCriteria[currentPage]'] = currentPage.toString();
    }

    final response = await _client.get(
      ApiEndpoints.products,
      queryParameters: queryParams,
      requiresAuth: false,
    );

    if (response is Map && response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }

    return [];
  }
}

