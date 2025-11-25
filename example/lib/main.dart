import 'package:flutter/material.dart';
import 'package:magento_api_client/magento_api_client.dart';

/// This example demonstrates how to initialize the Magento API client
/// and perform simple operations such as login, fetching products,
/// and interacting with the cart service.
void main() {
  runApp(const MagentoExampleApp());
}

class MagentoExampleApp extends StatefulWidget {
  const MagentoExampleApp({super.key});

  @override
  State<MagentoExampleApp> createState() => _MagentoExampleAppState();
}

class _MagentoExampleAppState extends State<MagentoExampleApp> {
  MagentoApiClient? _client;
  bool _isInitialized = false;
  String _status = 'Waiting for initialization...';

  @override
  void initState() {
    super.initState();
    _initializeClient();
  }

  Future<void> _initializeClient() async {
    setState(() {
      _status = 'Initializing client...';
    });

    try {
      _client = await MagentoApiClient.initGuest(
        'https://your-magento-domain.com',
      );

      setState(() {
        _isInitialized = true;
        _status = 'Client initialized. Ready to use services.';
      });
    } catch (e) {
      setState(() {
        _status = 'Initialization failed: $e';
      });
    }
  }

  Future<void> _sampleLogin() async {
    setState(() {
      _status = 'Logging in...';
    });

    try {
      await _client!.login('customer@example.com', 'password123');
      final customer = _client!.currentCustomer;
      setState(() {
        _status =
            'Logged in as ${customer?.firstName ?? ''} ${customer?.lastName ?? ''}';
      });
    } catch (e) {
      setState(() {
        _status = 'Login failed: $e';
      });
    }
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _status = 'Fetching products...';
    });

    try {
      final products = await _client!.getProducts(pageSize: 5);
      setState(() {
        if (products.isEmpty) {
          _status = 'No products found.';
        } else {
          _status =
              'Fetched ${products.length} products. '
              'First product: ${products.first.name}';
        }
      });
    } catch (e) {
      setState(() {
        _status = 'Failed to fetch products: $e';
      });
    }
  }

  Future<void> _addToCart() async {
    setState(() {
      _status = 'Adding product to cart...';
    });

    try {
      final item = await _client!.addItemToCart(sku: 'sample-sku', qty: 1);
      setState(() {
        _status = 'Added to cart: ${item.name} (Qty: ${item.qty})';
      });
    } catch (e) {
      setState(() {
        _status = 'Failed to add to cart: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Magento API Client Example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(_status),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isInitialized ? _sampleLogin : null,
                child: const Text('Login as Customer'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isInitialized ? _fetchProducts : null,
                child: const Text('Fetch Products'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _isInitialized ? _addToCart : null,
                child: const Text('Add Item To Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
