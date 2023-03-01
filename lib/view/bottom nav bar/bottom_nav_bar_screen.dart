import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pavane/constants/colors.dart';
import 'package:pavane/view/home/home_screen.dart';
import 'package:pavane/view/library/library_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../fitting room/fitting_room_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_fill),
        title: ("Home"),
        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        activeColorPrimary: depOrange,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.library_books),
        title: ("Library"),
        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        activeColorPrimary: depOrange,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage("assets/images/fitting.png"),
        ),
        title: ("Fitting"),
        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        activeColorPrimary: depOrange,
        inactiveColorPrimary: black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill),
        title: ("Profile"),
        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        activeColorPrimary: depOrange,
        inactiveColorPrimary: black,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      LibraryScreen(),
      FittingRoomScreen(),
      ProfileScreen(),
    ];
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      hideNavigationBarWhenKeyboardShows: true,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
