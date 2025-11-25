# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2024-01-XX

### Added
- Initial release of Magento API Client package
- Singleton API client with multiple authentication methods:
  - OAuth1 authentication
  - Admin token authentication
  - Guest access
  - Customer token authentication (after login)
- Complete customer service with:
  - Login functionality
  - Sign up functionality
  - Get current customer information
  - Update customer information
  - Change password
  - Reset password
  - Logout functionality
- Product service with:
  - Get products with pagination and filters
  - Get product by SKU
  - Search products
  - Get products by category
- Cart service with:
  - Guest cart operations (create, get, add item, update item, remove item)
  - Customer cart operations (create, get, add item, update item, remove item)
  - Smart cart methods that auto-detect guest or customer
- Order service with:
  - Get customer orders
  - Get order by ID
  - Get all orders (admin access)
- Category service with:
  - Get all categories
  - Get category by ID
  - Get category tree
- Complete data models:
  - Customer model with addresses
  - Product model with media gallery
  - Cart model with items and totals
  - Order model with items and addresses
  - Category model with tree structure
- Storage management:
  - Automatic token storage
  - Customer ID and email storage
  - Cart ID storage (guest and customer)
- Error handling with custom ApiException
- Comprehensive constants for API endpoints
- Full documentation in README

### Dependencies
- http: ^1.2.0
- shared_preferences: ^2.2.2
- oauth1: ^2.0.3
- crypto: ^3.0.3
