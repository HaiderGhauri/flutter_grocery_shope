import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class ProductCard extends StatelessWidget {
  // Add properties for dynamic data
  final String imagePath;
  final String price;
  final String title;
  final Color backgroundColor;
  final Color iconButtonColor; 
  final VoidCallback onAddPressed; 

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.price,
    required this.title,
    this.backgroundColor = AppColors.white1, // Default value
    this.iconButtonColor = AppColors.primaryLightBlue, // Default value
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor, // Dynamic background color
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: SvgPicture.asset(
                    imagePath, // Dynamic image path
                    width: double.infinity,
                    height: 70,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: iconButtonColor, // Dynamic icon button color
                    shape: BoxShape.circle,
                  ),
                  width: 28,
                  height: 28,
                  child: IconButton(
                    onPressed: onAddPressed, // Use the passed callback
                    icon: const Icon(Icons.add, size: 16),
                    color: AppColors.white1,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Text(
            '\$$price', // Dynamic price
            style: const TextStyle(
              color: AppColors.black2,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          Text(
            title, // Dynamic title
            style: TextStyle(
              color: AppColors.black3,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}