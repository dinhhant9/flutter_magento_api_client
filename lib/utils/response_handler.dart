import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_exception.dart';

/// Handles API responses and errors
class ResponseHandler {
  /// Process HTTP response
  static dynamic handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }
      try {
        return json.decode(response.body);
      } catch (e) {
        return response.body;
      }
    } else {
      String errorMessage = 'Request failed';
      try {
        final errorBody = json.decode(response.body);
        if (errorBody is Map && errorBody.containsKey('message')) {
          errorMessage = errorBody['message'];
        } else {
          errorMessage = response.body;
        }
      } catch (e) {
        errorMessage = response.body.isNotEmpty 
            ? response.body 
            : 'HTTP ${response.statusCode}';
      }
      throw ApiException(
        errorMessage,
        statusCode: response.statusCode,
        response: response.body,
      );
    }
  }
}

