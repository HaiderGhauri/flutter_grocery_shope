import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:grocery_shope/constants/app_theme.dart';
class ProductDetailSheet extends StatelessWidget {
  final String id;
  final String imagePath;
  final String title;
  final String price;
  final String? category;
  final List<String>? tags;
  final String description; 
  final VoidCallback onAddToCart; 

  const ProductDetailSheet({
    super.key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.price,
    this.category,
    this.tags,
    this.description = 'No detailed description available for this product.', // Default description
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      decoration: const BoxDecoration(
        color: AppColors.white1, // Background color of the sheet
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: AppColors.gray2,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Product Image
          Center(
            child: SvgPicture.asset(
              imagePath,
              height: 120, // Larger image for detail view
              width: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24),

          // Product Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black1,
            ),
          ),
          const SizedBox(height: 8),

          // Price and Category (in a Row)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$price',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryLightBlue, // Highlight price
                ),
              ),
              if (category != null && category!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gray3,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    category!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Tags (similar to ProductCard, but can be styled differently)
          if (tags != null && tags!.isNotEmpty) ...[
            Wrap(
              spacing: 6.0,
              runSpacing: 4.0,
              children: List.generate(tags!.length, (index) {
                return Text(
                  tags![index] + (index < tags!.length - 1 ? ', ' : ''), // Add comma
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.black3,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
          ],

          // Product Description
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.black3,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Add to Cart Button
          SizedBox(
            width: double.infinity, // Full width button
            child: ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLightBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white1,
                ),
              ),
            ),
          ),

          // For bottom padding when keyboard appears, or just a safe area
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const SizedBox(height: 16), // Extra bottom space
          ),
        ],
      ),
    );
  }
}