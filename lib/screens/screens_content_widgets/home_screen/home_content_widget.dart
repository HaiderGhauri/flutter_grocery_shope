import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';
import 'package:grocery_shope/screens/screens_content_widgets/home_screen/widgets/off_card_widget.dart';
import 'package:grocery_shope/widgets/product_card_widget.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productsData = [
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '20',
      'title': 'Orange Package 1',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '35',
      'title': 'Red Apples Box',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '12',
      'title': 'Green Grapes',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '50',
      'title': 'Mixed Veggies',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '18',
      'title': 'Bananas Bunch',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '25',
      'title': 'Fresh Carrots',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '8',
      'title': 'Lemons Bag',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
    {
      'imagePath': 'assets/images/image_placeholder.svg',
      'price': '42',
      'title': 'Pineapple Large',
      'backgroundColor': AppColors.white1,
      'iconButtonColor': AppColors.primaryLightBlue,
    },
  ];

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero section
          Container(
            color: AppColors.primaryLightBlue,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    margin: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDarkBlue,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: AppColors.gray3),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search Products",
                              hintStyle: TextStyle(color: AppColors.gray1),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                'DELIVERY TO',
                                style: TextStyle(color: AppColors.gray3),
                              ),
                            ),
                            Text(
                              'Green Way 3000',
                              style: TextStyle(
                                color: AppColors.gray3,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                'WITHIN',
                                style: TextStyle(color: AppColors.gray3),
                              ),
                            ),
                            Text(
                              '1 Hour',
                              style: TextStyle(
                                color: AppColors.gray3,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main section
          Container(
            margin: EdgeInsets.only(top: 24, right: 18, left: 18, bottom: 14),
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
                        cardColor: AppColors.primaryDarkYellow,
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
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.95,
                  children: productsData.map((product) {
                    return ProductCard(
                      imagePath: product['imagePath'],
                      price: product['price'],
                      title: product['title'],
                      backgroundColor: product['backgroundColor'],
                      iconButtonColor: product['iconButtonColor'],
                      onAddPressed: () {
                        print('Adding ${product['title']} to cart!');
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
