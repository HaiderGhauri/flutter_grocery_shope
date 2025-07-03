import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueSetter<int> onItemSelected; // Callback for when an item is tapped

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppColors.white1,
      color: AppColors.gray3,
      buttonBackgroundColor: AppColors.black1,
      height: 70.0,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      index: selectedIndex, // Use the passed selectedIndex
      items: [
        CurvedNavigationBarItem(
          child: Icon(
            Icons.home_rounded,
            color: selectedIndex == 0 ? AppColors.primaryLightYellow : AppColors.black2,
          ),
          label: 'Home',
          labelStyle: TextStyle(
            color: selectedIndex == 0 ? AppColors.gray3 : AppColors.black2,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            Icons.category_rounded,
            color: selectedIndex == 1 ? AppColors.primaryLightYellow : AppColors.black2,
          ),
          label: 'Categories',
          labelStyle: TextStyle(
            color: selectedIndex == 1 ? AppColors.gray3 : AppColors.black2,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            Icons.shopping_bag,
            color: selectedIndex == 2 ? AppColors.primaryLightYellow : AppColors.black2,
          ),
          label: 'Cart',
          labelStyle: TextStyle(
            color: selectedIndex == 2 ? AppColors.gray3 : AppColors.black2,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            Icons.more_vert_rounded,
            color: selectedIndex == 3 ? AppColors.primaryLightYellow : AppColors.black2,
          ),
          label: 'More',
          labelStyle: TextStyle(
            color: selectedIndex == 3 ? AppColors.gray3 : AppColors.black2,
          ),
        ),
      ],
      onTap: onItemSelected, // Pass the callback directly
    );
  }
}