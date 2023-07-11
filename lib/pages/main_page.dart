import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winwin/bloc/favorite_bloc.dart';
import 'package:winwin/pages/favorite_page.dart';
import 'package:winwin/pages/home/home_page.dart';
import 'package:winwin/pages/profile/profile_settings_page.dart';

import '../data/repository/favorite_repository.dart';
import 'constant.dart';

class MainPage extends StatefulWidget {
  int currentIndex = 0;
  MainPage({this.currentIndex = 0, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Widget navigation() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: BottomNavigationBar(
          unselectedItemColor: backgroundColor,
          fixedColor: buttonColor,
          currentIndex: widget.currentIndex,
          onTap: (value) {
            setState(() {
              widget.currentIndex = value;
            });
          },
          backgroundColor: appBarColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/icon_home.svg',
                color: widget.currentIndex == 0 ? buttonColor : backgroundColor,
                width: 34,
                height: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/icon_contact.svg',
                  color:
                      widget.currentIndex == 1 ? buttonColor : backgroundColor,
                  width: 34,
                  height: 30,
                ),
                label: 'Contact'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/icon_person.svg',
                  color:
                      widget.currentIndex == 2 ? buttonColor : backgroundColor,
                  width: 34,
                  height: 30,
                ),
                label: 'Profile')
          ]),
    );
  }

  Widget body() {
    switch (widget.currentIndex) {
      case 0:
        return BlocProvider<FavoriteBloc>.value(
            value: BlocProvider.of<FavoriteBloc>(context),
            child: HomePage());
      case 1:
        return FavoritePage();
      case 2:
        return ProfileSettingsPage();
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
