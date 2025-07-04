import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_data.dart';
import 'package:grocery_shope/models/favourite_model.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/categories_screen/widgets/categories_hero_widget.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/categories_screen/widgets/category_filter_bar.dart';
import 'package:grocery_shope/utils/add_to_cart_utils.dart';
import 'package:grocery_shope/utils/product_detail_utils.dart';
import 'package:grocery_shope/widgets/product_card_widget.dart';
import 'package:provider/provider.dart';

class CategoriesContentWidget extends StatefulWidget {
  const CategoriesContentWidget({super.key});

  @override
  State<CategoriesContentWidget> createState() =>
      _CategoriesContentWidgetState();
}

class _CategoriesContentWidgetState extends State<CategoriesContentWidget> {
  String _selectedCategory = 'All'; // Default filter
  List<Map<String, dynamic>> _filteredProductsData = []; // Data from AppData

  @override
  void initState() {
    super.initState();
    _filterProducts(); // Initialize filtered products
  }

  // Function to filter products based on selected category
  void _filterProducts() {
    setState(() {
      if (_selectedCategory == 'All') {
        _filteredProductsData = productsData;
      } else {
        _filteredProductsData = productsData
            .where((productMap) => productMap['category'] == _selectedCategory)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FavouriteModel>(context);
    return Builder(
      builder: (context) {
        final List<String> categories =
            ['All'] +
            productsData
                .map<String>((productMap) => productMap['category'] as String)
                .toSet() // Remove duplicates
                .toList();
        return Column(
          children: [
            CategoriesHeroWidget(),
            CategoryFilterBar(
              categories: categories,
              initialSelectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                  _filterProducts();
                });
              },
            ),
            Expanded(
              // Important: Ensures GridView takes remaining space
              child: _filteredProductsData.isEmpty
                  ? const Center(
                      child: Text('No products found for this category.'),
                    )
                  : GridView.builder(
                      itemCount: _filteredProductsData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (context, index) {
                        final productData = _filteredProductsData[index];

                        return ProductCard(
                          id: productData['id'],
                          imagePath: productData['imagePath'],
                          price: productData['price'],
                          title: productData['title'],
                          category: productData['category'],
                          tags: productData['tags'] as List<String>,
                          isFav: productData['isFav'] as bool,
                          onToggleFavorite: (productId) {
                            Provider.of<FavouriteModel>(
                              context,
                              listen: false,
                            ).toggleFavourite(productId);
                          },
                          onAddPressed: () {
                            // Call the reusable function
                            addToCartAndShowSnackbar(
                              context,
                              id: productData['id'],
                              imagePath: productData['imagePath'],
                              price: productData['price'],
                              title: productData['title'],
                            );
                          },
                          onCardTap: () {
                            showProductDetailBottomSheet(context, productData);
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
