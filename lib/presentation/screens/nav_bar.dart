// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny_places/core/constants/constants_colors.dart';
import 'package:penny_places/presentation/screens/addPlacesScreens/add_places.dart';
import 'package:penny_places/presentation/screens/home/home_screen.dart';
import 'package:penny_places/presentation/screens/profileScreens/profile_screen.dart';
import 'package:penny_places/presentation/screens/settings/setting_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    Key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      const HomeScreen(),
      const AddPlaces(),
      const SettingScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        // When the back button is pressed, exit the app

        return false;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 28),
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black.withOpacity(0.5),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex: index,
              onTap: (int newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/home.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/homeF.svg',
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/add.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/addF.svg',
                  ),
                  label: ' Add Places',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/setting.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/setting.svg',
                    color: ConstantsColors.blueColor,
                  ),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/svg/user.svg'),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/userF.svg',
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
          body: screens[index],
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      index = index;
    });
  }

  bool exit = false;
}
