import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text(
        'Hey',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12.0, top: 5),
              child: Icon(Icons.shopping_bag_outlined, size: 28),
            ),
            Positioned(
              right: 3,
              top: 1,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.primaryDarkYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
                child: const Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}