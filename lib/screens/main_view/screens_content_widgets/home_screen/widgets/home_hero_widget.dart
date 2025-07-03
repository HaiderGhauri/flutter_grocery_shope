import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class HomeHeroWidget extends StatelessWidget {
  const HomeHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLightBlue,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              margin: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryDarkBlue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.gray3),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Products",
                        hintStyle: TextStyle(color: AppColors.gray1),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          'DELIVERY TO',
                          style: TextStyle(color: AppColors.gray3),
                        ),
                      ),
                      Text(
                        'Green Way 3000',
                        style: TextStyle(color: AppColors.gray3, fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          'WITHIN',
                          style: TextStyle(color: AppColors.gray3),
                        ),
                      ),
                      Text(
                        '1 Hour',
                        style: TextStyle(color: AppColors.gray3, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
