import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For ChangeNotifier

class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {}; // Product ID -> CartItem

  Map<String, CartItem> get items {
    return {..._items}; // Return a copy to prevent external modification
  }

  static const String _cartKey = 'cartData';

  CartModel() {
    // Constructor: Load cart data when CartModel is created
    _loadCartFromPrefs();
  }

  int get totalItems {
    return _items.length;
  }

  double get totalPrice {
    return _items.values.fold(
      0.0,
      (sum, item) => sum + (double.parse(item.price) * item.quantity),
    );
  }

  // --- Local Storage Functions ---

  // Load cart data from SharedPreferences
  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(_cartKey);

    if (cartJson != null) {
      final List<dynamic> decodedData = jsonDecode(cartJson);
      _items.clear(); // Clear existing items before loading
      for (var itemMap in decodedData) {
        // Ensure all required fields are present and cast correctly
        try {
          _items[itemMap['id']] = CartItem(
            id: itemMap['id'] as String,
            title: itemMap['title'] as String,
            price: itemMap['price'] as String,
            imagePath: itemMap['imagePath'] as String,
            quantity: itemMap['quantity'] as int,
          );
        } catch (e) {
          debugPrint('Error decoding cart item from local storage: $e');
          // Handle error, maybe clear corrupt data or log it
        }
      }
      notifyListeners(); // Notify listeners after loading
    }
  }

  // Save current cart data to SharedPreferences
  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert Map<String, CartItem> to List<Map<String, dynamic>> for JSON serialization
    final List<Map<String, dynamic>> cartList = _items.values
        .map(
          (item) => {
            'id': item.id,
            'title': item.title,
            'price': item.price,
            'imagePath': item.imagePath,
            'quantity': item.quantity,
          },
        )
        .toList();
    final String jsonString = jsonEncode(cartList);
    await prefs.setString(_cartKey, jsonString);
  }

  void addItem(String productId, String title, String price, String imagePath) {
    if (_items.containsKey(productId)) {
      // If item already in cart, just increase quantity
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          imagePath: existingItem.imagePath,
        ),
      );
    } else {
      // Add new item to cart
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
          imagePath: imagePath,
        ),
      );
    }
    notifyListeners(); // Notify all listening widgets about the change
    _saveCartToPrefs();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items.update(
          productId,
          (existingItem) => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            price: existingItem.price,
            imagePath: existingItem.imagePath,
            quantity: existingItem.quantity - 1,
          ),
        );
      } else {
        _items.remove(productId); // Remove completely if quantity is 1
      }
      notifyListeners();
      _saveCartToPrefs();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCartToPrefs();
  }
}

// A simple model for a cart item
class CartItem {
  final String id;
  final String title;
  final String price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.imagePath,
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}
