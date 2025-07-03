import 'package:flutter/material.dart';
import 'package:grocery_shope/screens/main_view/widgets/cart_icon_with_badge.dart';

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
        const CartIconWithBadge(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}