import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/routes.dart';
import 'package:grocery_shope/screens/onboarding_screen/widgets/onboarding_screnn_widget.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Your holiday shopping delivered to Screen one',
      'description':
          "There's something for everyone to enjoy with Sweet Shop Favourites Screen 1",
      'imagePath': 'assets/images/onboarding-icon.svg',
    },
    {
      'title': 'Your holiday shopping delivered to Screen one',
      'description':
          "There's something for everyone to enjoy with Sweet Shop Favourites Screen 1",
      'imagePath': 'assets/images/onboarding-icon.svg',
    },
  ];

  final PageController _pageController = PageController();
  int _currentPageIndex = 0; // Current page index for dots
  Timer? _timer; // Timer ko declare kiya

  @override
  void initState() {
    super.initState();
    // PageController par listener add karein taake page change hone par state update ho
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPageIndex = _pageController.page!.round();
        });
      }
    });

    // Timer shuru karein
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) { // Har 2 seconds baad slide karega
      if (_currentPageIndex < _onboardingData.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500), // Slide ki duration
          curve: Curves.easeIn,
        );
      } else {
        // Jab saare pages slide ho jayen, timer ko rok dein
        timer.cancel();
        // Aur next view par redirect karein
        _navigateToNextView();
      }
    });
  }

  void _navigateToNextView() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.mainRoute); 
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel(); // Dispose karte waqt timer ko cancel karna na bhulein
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              itemCount: _onboardingData.length,
              controller: _pageController,
              itemBuilder: (context, index) {
                final pageData = _onboardingData[index];
                return SpalshScrennWidget(
                  title: pageData['title'] as String,
                  description: pageData['description'] as String,
                  iconPath: pageData['imagePath'] as String,
                );
              },
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15 + 60, // Adjust position
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: _currentPageIndex == index ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: _currentPageIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
