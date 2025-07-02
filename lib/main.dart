import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';
import 'package:grocery_shope/screens/man_view/main_view.dart';
import 'package:grocery_shope/screens/splash_screen/splash_screen_view.dart';
import 'package:grocery_shope/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Shope',
      theme: ThemeData(
        primaryColor: AppColors.primaryLightBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLightBlue, // Base color for generating scheme
        primary: AppColors.primaryLightBlue,
        secondary: AppColors.primaryDarkYellow, // Jaise button ya accent colors
        surface: Colors.white, // Background for cards/sheets
        error: Colors.red, // Default error color
        onPrimary: AppColors.white1, // Text/Icons on primary color background
        onSecondary: AppColors.black1, // Text/Icons on secondary color background
        onSurface: AppColors.black1, // Text/Icons on surface background
      ),

      // 2. Scaffold Background Color
      scaffoldBackgroundColor: Colors.white,

      // 3. AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryLightBlue,
        foregroundColor: AppColors.white1, // Title aur icon color
        elevation: 0,
        centerTitle: true,
      ),
      ),
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.splashRoute: (context) => const SplashScreenView(),
        AppRoutes.homeRoute: (context) => const MainView(),
      },
    );
  }
}
