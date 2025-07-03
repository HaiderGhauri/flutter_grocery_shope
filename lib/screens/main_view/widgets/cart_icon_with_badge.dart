import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shope/models/cart_model.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class CartIconWithBadge extends StatelessWidget {
  const CartIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        final int totalItems =
            cart.totalItems; // Get total items from CartModel

        return Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_bag,
                color: AppColors.white1,
              ),
              onPressed: () {
                print('Navigating to Cart Screen');
                Navigator.pushNamed(context, AppRoutes.cartRoute);
              },
            ),
            if (totalItems > 0) // Only show badge if there are items
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color:
                        AppColors.primaryDarkYellow, // Badge background color
                    borderRadius: BorderRadius.circular(9),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$totalItems',
                    style: const TextStyle(
                      color: AppColors.white1,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
