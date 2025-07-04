import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_data.dart';
import 'package:grocery_shope/constants/app_theme.dart';
import 'package:grocery_shope/models/favourite_model.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/home_screen/widgets/home_hero_widget.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/home_screen/widgets/off_card_widget.dart';
import 'package:grocery_shope/utils/add_to_cart_utils.dart';
import 'package:grocery_shope/utils/product_detail_utils.dart';
import 'package:grocery_shope/widgets/product_card_widget.dart';
import 'package:provider/provider.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<FavouriteModel>(context);
    // --- Filter the productsData here ---
    final List<Map<String, dynamic>> filteredProducts = productsData.where((
      product,
    ) {
      final String category = product['category'];
      // Check if the product's category is 'Fruits' OR 'Vegetables'
      return category == 'Fruits' || category == 'Vegetables';
    }).toList();
    // --- End of filtering ---

    return Column(
      children: [
        // Hero section
        HomeHeroWidget(),
        // Main section
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 24, right: 18, left: 18, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 16,
                  children: [
                    Expanded(
                      child: OffCardWidget(
                        cardColor: AppColors.primaryLightYellow,
                      ),
                    ),
                    Expanded(
                      child: OffCardWidget(cardColor: Color(0xffE4DDCB)),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Deals on Fruits & Vegetables',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length, // Total number of items
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: double.infinity,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.92,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      id: product['id'],
                      imagePath: product['imagePath'],
                      price: product['price'],
                      title: product['title'],
                      isFav: product['isFav'] as bool,
                      onToggleFavorite: (productId) {
                            Provider.of<FavouriteModel>(
                              context,
                              listen: false,
                            ).toggleFavourite(productId);
                          },
                      onCardTap: () {
                        showProductDetailBottomSheet(context, product);
                      },
                      onAddPressed: () {
                        // Call the reusable function
                        addToCartAndShowSnackbar(
                          context,
                          id: product['id'],
                          imagePath: product['imagePath'],
                          price: product['price'],
                          title: product['title'],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
