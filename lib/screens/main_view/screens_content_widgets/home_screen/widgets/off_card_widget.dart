import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class OffCardWidget extends StatelessWidget {
  final Color cardColor;

  const OffCardWidget({super.key, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 28, right: 22, bottom: 28, left: 22),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.black1,
            ),
          ),
          Text(
            '50% OFF',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.black1,
            ),
          ),
          Text(
            'On first 03 order',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.black1,
            ),
          ),
        ],
      ),
    );
  }
}
