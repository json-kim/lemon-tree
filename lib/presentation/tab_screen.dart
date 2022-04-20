import 'package:flutter/material.dart';
import 'package:lemon_tree/presentation/constants/colors.dart';
import 'package:lemon_tree/presentation/home/home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    Container(),
    Container(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) {
          setState(() {
            _pageController.jumpToPage(idx);
            _currentIndex = idx;
          });
        },
        selectedItemColor: Colors.white.withOpacity(0.8),
        unselectedItemColor: darkGreen,
        backgroundColor: mainGreen,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
