/// Authentication types for Magento API
enum AuthType {
  /// OAuth 1.0 authentication
  oauth1,
  
  /// Admin token authentication
  adminToken,
  
  /// Guest access (no authentication)
  guest,
  
  /// Customer token authentication (after login)
  customerToken,
}

