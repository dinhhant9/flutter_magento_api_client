import '../api/api_client.dart';
import '../constants/api_endpoints.dart';
import '../models/category.dart';

/// Service for category-related operations
class CategoryService {
  final MagentoApiClient _client = MagentoApiClient.instance;

  /// Get all categories
  Future<List<Category>> getCategories({
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
      ApiEndpoints.categories,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      requiresAuth: false,
    );

    if (response is Map && response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Category.fromJson(item))
          .toList();
    }

    return [];
  }

  /// Get category by ID
  Future<Category> getCategoryById(int categoryId) async {
    final response = await _client.get(
      ApiEndpoints.categoryById(categoryId),
      requiresAuth: false,
    );

    return Category.fromJson(response);
  }

  /// Get category tree (with children)
  Future<Category> getCategoryTree({
    int? rootCategoryId,
    int? depth,
  }) async {
    final queryParams = <String, String>{};

    if (rootCategoryId != null) {
      queryParams['rootCategoryId'] = rootCategoryId.toString();
    }
    if (depth != null) {
      queryParams['depth'] = depth.toString();
    }

    final response = await _client.get(
      ApiEndpoints.categories,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      requiresAuth: false,
    );

    return Category.fromJson(response);
  }
}

