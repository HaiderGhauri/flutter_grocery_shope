import 'package:flutter/material.dart';
import 'package:grocery_shope/screens/cart_screen/cart_screen_view.dart';
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
    const CartScreenView(),
    const Center(child: Text('More Content', style: TextStyle(fontSize: 24))),
  ];

  // This method will be passed to CustomBottomNavBar's onItemSelected
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index); // Make PageView show the selected tab's content
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
            _selectedIndex = index; // Keep the bottom bar and page in sync
          });
        },
        children: _tabViews, // Your list of main tab content widgets
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex, // Pass the current selected index
        onItemSelected: _onNavBarTap, // Pass the callback method
      ),
    );
  }
}
