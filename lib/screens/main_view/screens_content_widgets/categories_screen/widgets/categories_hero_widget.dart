import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class CategoriesHeroWidget extends StatelessWidget {
  const CategoriesHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLightBlue,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shop',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w300,
                color: AppColors.white1,
              ),
            ),
            Text(
              'By Category',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: AppColors.white1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}