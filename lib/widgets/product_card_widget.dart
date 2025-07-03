// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:grocery_shope/constants/app_theme.dart';

// class ProductCard extends StatelessWidget {
//   // Add properties for dynamic data
//   final String imagePath;
//   final String price;
//   final String title;
//   final VoidCallback onAddPressed;

//   const ProductCard({
//     super.key,
//     required this.imagePath,
//     required this.price,
//     required this.title,
//     required this.onAddPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.white1, // Dynamic background color
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child: Center(
//                   child: SvgPicture.asset(
//                     imagePath, // Dynamic image path
//                     width: double.infinity,
//                     height: 70,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryLightBlue, // Dynamic icon button color
//                     shape: BoxShape.circle,
//                   ),
//                   width: 28,
//                   height: 28,
//                   child: IconButton(
//                     onPressed: onAddPressed, // Use the passed callback
//                     icon: const Icon(Icons.add, size: 16),
//                     color: AppColors.white1,
//                     padding: EdgeInsets.zero,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 14),

//           Text(
//             '\$$price', // Dynamic price
//             style: const TextStyle(
//               color: AppColors.black2,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),

//           Text(
//             title, // Dynamic title
//             style: TextStyle(
//               color: AppColors.black3,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/widgets/product_card_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this is imported if you use SvgPicture
import 'package:grocery_shope/constants/app_theme.dart'; // For AppColors

class ProductCard extends StatelessWidget {
  final String id;
  final String imagePath;
  final String price;
  final String title;
  final String? category;
  final List<String>? tags;
  final Color? backgroundColor;
  final Color? iconButtonColor;
  final VoidCallback onAddPressed; // For the plus button
  final VoidCallback onCardTap; // For the entire card tap

  const ProductCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.price,
    required this.title,
    this.category,
    this.tags,
    this.backgroundColor = AppColors.white1,
    this.iconButtonColor = AppColors.primaryLightBlue,
    required this.onAddPressed,
    required this.onCardTap,
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
          final double bottomOffset = constraints.maxHeight * 0.5;
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
                child: SizedBox(
                  // <--- Wrap Ink with SizedBox for precise size control
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
                      icon: const Icon(Icons.add_rounded, color: Colors.white),
                      onPressed: onAddPressed,
                      iconSize:
                          18, // Can make this even smaller if needed (e.g., 16, 14)
                      splashRadius:
                          15, // Make splashRadius smaller to match new button size
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
