import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_shope/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shope/models/cart_model.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class CartScreenView extends StatelessWidget {
  const CartScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the CartModel to rebuild when cart changes
    final cart = Provider.of<CartModel>(context);

    final bool isCartEmpty = cart.totalItems == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sopping Cart'),
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        foregroundColor: AppColors.white1,
      ),
      body: Column(
        children: [
          Expanded(
            child: isCartEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your cart is empty. Start shopping!',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.gray1,
                          ),
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.mainRoute,
                            ); // Go back to the previous screen (e.g., CategoryScreen)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDarkYellow,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: Text(
                            'Go Back to Shopping',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items.values.elementAt(index);
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 0,
                        color: Colors.white,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.gray2,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  cartItem.imagePath,
                                  height: 40, // Adjust size as needed
                                  width: 60,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black1,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${cartItem.price}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.black1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Material(
                                      color: AppColors.gray3,
                                      borderRadius: BorderRadius.circular(18),
                                      child: InkWell(
                                        onTap: () {
                                          cart.removeItem(cartItem.id);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColors.black1,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${cartItem.quantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Material(
                                      color: AppColors.gray3,
                                      borderRadius: BorderRadius.circular(18),
                                      child: InkWell(
                                        onTap: () {
                                          // Re-add item to increase quantity
                                          cart.addItem(
                                            cartItem.id,
                                            cartItem.title,
                                            cartItem.price,
                                            cartItem.imagePath,
                                          );
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(7.0),
                                          child: Icon(
                                            Icons.add,
                                            color: AppColors.black1,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Cart Summary
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.gray3,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(18),
                right: Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Items:',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black3,
                            ),
                          ),
                          Text(
                            '${cart.totalItems}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black1,
                            ),
                          ),
                          Text(
                            '\$${cart.totalPrice.toStringAsFixed(2)}', // Format to 2 decimal places
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryLightBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        isCartEmpty // <<<--- Conditional onPressed
                        ? null // Set to null to disable the button
                        : () {
                            // TODO: Implement actual checkout logic here
                            cart.clearCart(); // Clear cart after checkout (for demo)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: AppColors.primaryDarkYellow,
                                content: Text(
                                  'Checkout successful! Cart cleared.',
                                ),
                              ),
                            );
                            Navigator.pop(context); // Go back after checkout
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLightBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
