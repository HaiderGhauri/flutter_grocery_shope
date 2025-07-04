import 'package:flutter/foundation.dart';
import 'package:grocery_shope/constants/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteModel extends ChangeNotifier {
  FavouriteModel() {
    _loadFavouriteItem(); // Implement this if using SharedPreferences
  }

  List<Map<String, dynamic>> get favouriteProducts {
    return productsData.where((product) => product['isFav'] == true).toList();
  }

  void toggleFavourite(String productId) {
    final productIndex = productsData.indexWhere(
      (product) => product['id'] == productId,
    );

    if (productIndex != 1) {
      final currentIsFav = productsData[productIndex]['isFav'] as bool;

      productsData[productIndex]['isFav'] = !currentIsFav;

      notifyListeners();
      _saveFavouriteItem();
    } else {
      debugPrint('Error: Product with ID $productId not found in AppData.');
    }
  }

  static const String _favKey = 'favoriteProductIds';

  Future<void> _loadFavouriteItem() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? favIds = prefs.getStringList(_favKey);

    if (favIds != null) {
      for (var product in productsData) {
        product['isFav'] = favIds.contains(product['id']);
      }
    }
    notifyListeners();
  }

  Future<void> _saveFavouriteItem() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> currentFavIds = favouriteProducts
        .map((p) => p['id'] as String)
        .toList();

    await prefs.setStringList(_favKey, currentFavIds);
  }
}
