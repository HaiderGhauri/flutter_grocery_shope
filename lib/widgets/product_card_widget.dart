import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String price;
  final String title;
  final bool isFav;
  final String? category;
  final List<String>? tags;
  final Color? backgroundColor;
  final Color? iconButtonColor;
  final VoidCallback onAddPressed; // For the plus button
  final VoidCallback onCardTap; // For the entire card tap
  final Function(String productId) onToggleFavorite;

  const ProductCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.price,
    required this.title,
    required this.isFav,
    this.category,
    this.tags,
    this.backgroundColor = AppColors.white1,
    this.iconButtonColor = AppColors.primaryLightBlue,
    required this.onAddPressed,
    required this.onCardTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double rightOffset = constraints.maxWidth * 0.05;
          final double bottomOffset = constraints.maxHeight * 0.4;
          return Stack(
            children: [
              InkWell(
                onTap: onCardTap, // This handles the tap for the whole card
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Center(
                        child: SvgPicture.asset(
                          imagePath,
                          height: 70, // Adjust size as needed
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Price
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black1,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Category (smaller text)
                      if (category != null && category!.isNotEmpty) ...[
                        const SizedBox(height: 4), // Space above category
                        Text(
                          category!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.black3,
                          ),
                        ),
                      ],
                      // Tags (using Wrap for multiple)
                      if (tags != null && tags!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 2.0,
                          children: List.generate(tags!.length, (index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tags![index],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.black3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (index < tags!.length - 1)
                                  const Text(
                                    ' &',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.black3,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Positioned(
                right: rightOffset,
                bottom: bottomOffset,
                child: Row(
                  children: [
                    SizedBox(
                      width: 30, // Adjust this width
                      height: 30, // Adjust this height
                      child: Ink(
                        decoration: BoxDecoration(
                          color: iconButtonColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                          ),
                          onPressed: onAddPressed,
                          iconSize: 18,
                          splashRadius: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 30, // Adjust this width
                      height: 30, // Adjust this height
                      child: Ink(
                        decoration: BoxDecoration(
                          color: iconButtonColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            onToggleFavorite(id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryDarkYellow,
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  isFav
                                      ? '$title removed from favorites!'
                                      : '$title added to favorites!',
                                  style: const TextStyle(
                                    color: AppColors.white1,
                                  ),
                                ),
                              ),
                            );
                          },
                          iconSize: 18,
                          splashRadius: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
