import 'package:flutter/material.dart';
import 'package:grocery_shope/constants/app_theme.dart';
import 'package:grocery_shope/models/cart_model.dart';
import 'package:grocery_shope/models/favourite_model.dart';
import 'package:grocery_shope/screens/cart_screen/cart_screen_view.dart';
import 'package:grocery_shope/screens/main_view/main_view.dart';
import 'package:grocery_shope/screens/onboarding_screen/onboarding_screen_view.dart';
import 'package:grocery_shope/constants/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => FavouriteModel()),
      ],

      child: MaterialApp(
        title: 'Grocery Shope',
        theme: ThemeData(
          primaryColor: AppColors.primaryLightBlue,
          colorScheme: ColorScheme.fromSeed(
            seedColor:
                AppColors.primaryLightBlue, 
            primary: AppColors.primaryLightBlue,
            secondary:
                AppColors.primaryDarkYellow, 
            surface: Colors.white, 
            error: Colors.red, 
            onPrimary:
                AppColors.white1, 
            onSecondary:
                AppColors.black1, 
            onSurface: AppColors.black1, 
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
          AppRoutes.mainRoute: (context) => const MainView(),
          AppRoutes.cartRoute: (context) => const CartScreenView(),
        },
      ),
    );
  }
}
