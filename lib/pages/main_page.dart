import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winwin/pages/favorite_page.dart';
import 'package:winwin/pages/home/home_page.dart';
import 'package:winwin/pages/profile.dart';

import 'constant.dart';
import 'home/edit_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  Widget navigation() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: BottomNavigationBar(
          unselectedItemColor: backgroundColor,
          fixedColor: buttonColor,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          backgroundColor: appBarColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/icon_home.svg',
                color: currentIndex == 0 ? buttonColor : backgroundColor,
                width: 34,
                height: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/icon_contact.svg',
                  color: currentIndex == 1 ? buttonColor : backgroundColor,
                  width: 34,
                  height: 30,
                ),
                label: 'Contact'),
            // BottomNavigationBarItem(
            //     icon: SvgPicture.asset(
            //       'assets/svg/icon_chat_blue.svg', color: currentIndex == 2 ? buttonColor : backgroundColor,
            //       width: 34,
            //       height: 30,
            //     ),
            //     label: 'Chat'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/icon_person.svg',
                  color: currentIndex == 2 ? buttonColor : backgroundColor,
                  width: 34,
                  height: 30,
                ),
                label: 'Profile')
          ]),
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return FavoritePage();
      case 2:
        return EditProfilePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: backgroundColor,
      body: body(),
    );
  }
}
