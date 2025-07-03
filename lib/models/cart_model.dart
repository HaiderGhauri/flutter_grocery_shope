import 'package:flutter/foundation.dart'; // For ChangeNotifier

class CartModel extends ChangeNotifier {
  // Assuming CartItem stores product ID and quantity
  final Map<String, CartItem> _items = {}; // Product ID -> CartItem

  Map<String, CartItem> get items {
    return {..._items}; // Return a copy to prevent external modification
  }

  int get totalItems {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return _items.values.fold(
      0.0,
      (sum, item) => sum + (double.parse(item.price) * item.quantity),
    );
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
          quantity: existingItem.quantity + 1, imagePath: existingItem.imagePath,
        ),
      );
    } else {
      // Add new item to cart
      _items.putIfAbsent(
        productId,
        () => CartItem(id: productId, title: title, price: price, quantity: 1, imagePath: imagePath, ),
      );
    }
    notifyListeners(); // Notify all listening widgets about the change
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
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
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
