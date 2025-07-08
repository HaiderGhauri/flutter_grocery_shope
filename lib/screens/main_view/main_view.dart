import 'package:flutter/material.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/favourite_screen/favourite_content_widget.dart';
import 'package:grocery_shope/screens/main_view/widgets/custom_app_bar.dart';
import 'package:grocery_shope/screens/main_view/widgets/custom_bottom_navbar.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/categories_screen/categories_content_widget.dart';
import 'package:grocery_shope/screens/main_view/screens_content_widgets/home_screen/home_content_widget.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  late PageController _pageController; // PageController is perfect for this!

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // This list holds your actual content widgets for each tab
  static final List<Widget> _tabViews = <Widget>[
    const HomeContentWidget(),
    const CategoriesContentWidget(),
    const FavouriteContentWidget(),
  ];


  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _tabViews, 
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex, // Pass the current selected index
        onItemSelected: _onNavBarTap, // Pass the callback method
      ),
    );
  }
}
