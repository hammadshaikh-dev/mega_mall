// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart'; // Import dummyProducts
import '../utils/price_utils.dart'; // Import parsePrice

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  // Access the dummy products
  List<Product> get products => dummyProducts;

  // Calculate total amount in cart
  double get totalAmount {
    double total = 0;
    _items.forEach((key, item) {
      final price = parsePrice(item.product.price); // Use parsePrice from price_utils.dart
      total += price * item.quantity;
    });
    return total;
  }

  // Add a product to the cart
  void addItem(Product product) {
    if (_items.containsKey(product.name)) {
      _items.update(
        product.name,
        (existing) => CartItem(
          product: existing.product,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.name,
        () => CartItem(product: product, quantity: 1),
      );
    }
    notifyListeners();
  }

  // Clear the entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// Model for cart item
class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
}
