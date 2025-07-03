import 'package:flutter/material.dart';
import 'package:grocery_shope/utils/add_to_cart_utils.dart';
import 'package:grocery_shope/widgets/product_detail_sheet.dart';

void showProductDetailBottomSheet(
  BuildContext context,
  Map<String, dynamic> productData,
) {
  final String id = productData['id'] as String? ?? 'N/A';
  final String imagePath =
      productData['imagePath'] as String? ??
      'assets/images/image_placeholder.svg';
  final String price = productData['price'] as String? ?? '0.00';
  final String title = productData['title'] as String? ?? 'Unknown Product';
  final String? category = productData['category'] as String?;
  final List<String>? tags = (productData['tags'] as List?)
      ?.where((item) => item != null)
      .map((item) => item.toString())
      .toList();
  final String description =
      productData['description'] as String? ??
      'A fresh and delicious product for your daily needs.';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext sheetContext) {
      return ProductDetailSheet(
        id: id,
        imagePath: imagePath,
        price: price,
        title: title,
        category: category,
        tags: tags,
        description: description,
        onAddToCart: () {
          addToCartAndShowSnackbar(
            sheetContext,
            id: id,
            title: title,
            price: price,
            imagePath: imagePath,
          );
          Navigator.pop(sheetContext); // Close the sheet after adding to cart
        },
      );
    },
  );
}
