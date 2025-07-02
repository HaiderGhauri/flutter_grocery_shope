import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_shope/constants/app_theme.dart';

class SpalshScrennWidget extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;

  const SpalshScrennWidget({
    super.key,
    required this.title,
    required this.description,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2A4BA0),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      child: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12, right: 40),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffFAFBFD),
                        height: 1.4,
                      ),
                    ),
                    TextSpan(text: '           '),
                    WidgetSpan(child: SvgPicture.asset(iconPath)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Color(0xffFAFBFD),
                ),
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              // --- Padding badhane ke liye ---
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              maximumSize: const Size(253, 70),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Get Started", style: TextStyle(fontSize: 16, color: AppColors.black1)),
                Icon(Icons.arrow_forward_outlined, color: AppColors.black1,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}