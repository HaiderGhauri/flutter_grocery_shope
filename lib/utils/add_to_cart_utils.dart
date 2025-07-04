import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shope/models/cart_model.dart';
import 'package:grocery_shope/constants/app_theme.dart';


void addToCartAndShowSnackbar(
  BuildContext context, {
  required String id,
  required String title,
  required String price,
  required String imagePath,
}) {
  // Access the CartModel using Provider
  Provider.of<CartModel>(context, listen: false).addItem(
    id,
    title,
    price,
    imagePath,
  );

  // Show a SnackBar notification
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primaryDarkYellow,
      duration: const Duration(seconds: 1),
      content: Text(
        '$title added to cart!',
        style: const TextStyle(color: AppColors.white1),
      ),
    ),
  );
}