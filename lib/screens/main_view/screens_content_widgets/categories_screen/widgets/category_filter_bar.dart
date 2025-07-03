import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class CategoryFilterBar extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected; // Callback for parent
  final String initialSelectedCategory;

  const CategoryFilterBar({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.initialSelectedCategory = 'All', // Default to 'All'
  });

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialSelectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 18, bottom: 6, right: 16, left: 16),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: widget.categories.map((category) {
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
              widget.onCategorySelected(category); // Notify parent
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryDarkYellow : AppColors.white1,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: isSelected ? AppColors.primaryDarkYellow : AppColors.gray1,
                  width: 1,
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? AppColors.white1 : AppColors.black1,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}