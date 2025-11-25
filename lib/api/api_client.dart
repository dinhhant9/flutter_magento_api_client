import 'dart:convert';
import 'package:http/http.dart' as http;
// TODO: Implement OAuth1 support
// import 'package:oauth1/oauth1.dart' as oauth1;
import '../constants/api_constants.dart';
import '../storage/storage_manager.dart';
import '../utils/api_exception.dart';
import '../utils/response_handler.dart';
import 'auth_type.dart';

/// Configuration for API client initialization
class MagentoApiConfig {
  final String baseUrl;
  final AuthType authType;
  final String? adminToken;
  final String? oauthConsumerKey;
  final String? oauthConsumerSecret;
  final String? oauthToken;
  final String? oauthTokenSecret;
  final Duration? timeout;

  MagentoApiConfig({
    required this.baseUrl,
    this.authType = AuthType.guest,
    this.adminToken,
    this.oauthConsumerKey,
    this.oauthConsumerSecret,
    this.oauthToken,
    this.oauthTokenSecret,
    this.timeout,
  });
}

/// Singleton API client for Magento REST API
class NetworkClient {
  static NetworkClient? _instance;
  late String _baseUrl;
  AuthType _authType = AuthType.guest;
  String? _adminToken;
  // TODO: Implement OAuth1 support
  // oauth1.Platform? _oauthPlatform;
  String? _oauthToken;
  String? _oauthTokenSecret;
  String? _oauthConsumerKey;
  String? _oauthConsumerSecret;
  Duration _timeout = const Duration(seconds: ApiConstants.defaultTimeout);

  // Private constructor
  NetworkClient._();

  /// Get singleton instance
  static NetworkClient get instance {
    _instance ??= NetworkClient._();
    return _instance!;
  }

  /// Initialize the API client
  static Future<void> init(MagentoApiConfig config) async {
    final client = instance;
    client._baseUrl = config.baseUrl.endsWith('/')
        ? config.baseUrl.substring(0, config.baseUrl.length - 1)
        : config.baseUrl;
    client._authType = config.authType;
    client._adminToken = config.adminToken;
    client._timeout = config.timeout ?? const Duration(seconds: ApiConstants.defaultTimeout);

    if (config.authType == AuthType.oauth1) {
      if (config.oauthConsumerKey == null || config.oauthConsumerSecret == null) {
        throw ApiException('OAuth1 requires consumerKey and consumerSecret');
      }
      // TODO: Implement OAuth1 signing
      // OAuth1 support is planned for future release
      // For now, store credentials for manual implementation
      client._oauthConsumerKey = config.oauthConsumerKey;
      client._oauthConsumerSecret = config.oauthConsumerSecret;
      client._oauthToken = config.oauthToken;
      client._oauthTokenSecret = config.oauthTokenSecret;
      throw ApiException('OAuth1 authentication is not yet implemented. Please use Admin Token or Guest access.');
    }

    // Initialize storage
    await StorageManager.init();
  }

  /// Get current authentication type
  AuthType get authType => _authType;

  /// Set customer token (after login)
  Future<void> setCustomerToken(String token) async {
    _authType = AuthType.customerToken;
    await StorageManager.saveUserToken(token);
  }

  /// Clear customer token (logout)
  Future<void> clearCustomerToken() async {
    _authType = AuthType.guest;
    await StorageManager.removeUserToken();
    await StorageManager.removeCustomerId();
    await StorageManager.removeCustomerEmail();
  }

  /// Get current customer token
  Future<String?> getCustomerToken() async {
    return await StorageManager.getUserToken();
  }

  /// Build full URL
  String _buildUrl(String endpoint) {
    return '$_baseUrl$endpoint';
  }

  /// Get headers for request
  Future<Map<String, String>> _getHeaders({
    Map<String, String>? additionalHeaders,
    bool requiresAuth = true,
  }) async {
    final headers = <String, String>{
      'Content-Type': ApiConstants.contentTypeJson,
      'Accept': ApiConstants.contentTypeJson,
    };

    if (requiresAuth) {
      if (_authType == AuthType.adminToken && _adminToken != null) {
        headers['Authorization'] = 'Bearer $_adminToken';
      } else if (_authType == AuthType.customerToken) {
        final token = await StorageManager.getUserToken();
        if (token != null) {
          headers['Authorization'] = 'Bearer $token';
        }
      }
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  /// Make GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    var url = _buildUrl(endpoint);
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final uri = Uri.parse(url);
      url = uri.replace(queryParameters: queryParameters).toString();
    }

    final request = http.Request('GET', Uri.parse(url));
    final requestHeaders = await _getHeaders(
      additionalHeaders: headers,
      requiresAuth: requiresAuth,
    );
    request.headers.addAll(requestHeaders);

    final streamedResponse = await request.send().timeout(_timeout);
    final response = await http.Response.fromStream(streamedResponse);
    return ResponseHandler.handleResponse(response);
  }

  /// Make POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    final url = _buildUrl(endpoint);
    final bodyJson = body != null ? json.encode(body) : null;

    final request = http.Request('POST', Uri.parse(url));
    if (bodyJson != null) {
      request.body = bodyJson;
    }
    final requestHeaders = await _getHeaders(
      additionalHeaders: headers,
      requiresAuth: requiresAuth,
    );
    request.headers.addAll(requestHeaders);

    final streamedResponse = await request.send().timeout(_timeout);
    final response = await http.Response.fromStream(streamedResponse);
    return ResponseHandler.handleResponse(response);
  }

  /// Make PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    final url = _buildUrl(endpoint);
    final bodyJson = body != null ? json.encode(body) : null;

    final request = http.Request('PUT', Uri.parse(url));
    if (bodyJson != null) {
      request.body = bodyJson;
    }
    final requestHeaders = await _getHeaders(
      additionalHeaders: headers,
      requiresAuth: requiresAuth,
    );
    request.headers.addAll(requestHeaders);

    final streamedResponse = await request.send().timeout(_timeout);
    final response = await http.Response.fromStream(streamedResponse);
    return ResponseHandler.handleResponse(response);
  }

  /// Make DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    final url = _buildUrl(endpoint);

    final request = http.Request('DELETE', Uri.parse(url));
    final requestHeaders = await _getHeaders(
      additionalHeaders: headers,
      requiresAuth: requiresAuth,
    );
    request.headers.addAll(requestHeaders);

    final streamedResponse = await request.send().timeout(_timeout);
    final response = await http.Response.fromStream(streamedResponse);
    return ResponseHandler.handleResponse(response);
  }
}

