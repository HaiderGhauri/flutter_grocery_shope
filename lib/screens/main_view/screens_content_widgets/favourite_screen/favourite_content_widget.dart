import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';
import 'package:grocery_shope/models/favourite_model.dart';
import 'package:grocery_shope/utils/add_to_cart_utils.dart';
import 'package:grocery_shope/utils/product_detail_utils.dart';
import 'package:grocery_shope/widgets/product_card_widget.dart';
import 'package:provider/provider.dart';

class FavouriteContentWidget extends StatelessWidget {
  const FavouriteContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteModel = Provider.of<FavouriteModel>(context);

    final favouriteItems = favouriteModel.favouriteProducts;

    return Container(
      child: favouriteItems.isEmpty
          ? Center(
              child: Text(
                'No favorites yet! Tap the heart icon on products.',
                style: TextStyle(fontSize: 16, color: AppColors.gray1),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 24,
                right: 18,
                left: 18,
                bottom: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    'Favourites Items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouriteItems.length, // Total number of items
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          // maxCrossAxisExtent: double.infinity,
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.92,
                        ),
                    itemBuilder: (context, index) {
                      final product = favouriteItems[index];
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
    );
  }
}
