import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winwin/data/models/favorite_model.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/main_page.dart';
//import 'package:winwin/pages/main_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/user_bloc.dart';
import '../data/models/user_model.dart';
import '../data/singleton/user_data.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  UserModel? user = UserData.user;
  List<UserModel> users = [];

  late DateTime dateOfBirth;
  late DateTime now;
  late Duration ageDuration;
  late int ageYears;

  void iniState() {
    super.initState();
    UserData.loadUser();
    users = UserBloc.userList;
  }

  @override
  Widget build(BuildContext context) {
    users = UserBloc.userList;
    // print("user fav: ${user!.favorite!.length}");
    // print("users fav: ${users.length}");

    List<UserModel> userFavorite = user!.favorite!
        .map((favorite) => users
        .where((user) => favorite.userFavoriteId == user.id)
        .toList())
        .expand((element) => element)
        .toList();

    // print("user favorit: ${userFavorite.length}");


    List<FavoriteModel> favoriteUsers = [];

    favoriteUsers.map((e) => print(e.id));

    Widget search() {
      return Container(
          width: double.infinity,
          height: 35,
          margin: EdgeInsets.only(top: 55),
          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            SvgPicture.asset(
              "assets/svg/icon_search.svg",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Find contact you want to search for",
              style: textColor2TextStyle.copyWith(
                  fontSize: 12, fontStyle: FontStyle.italic),
            )
          ]));
    }

    Widget yourname(UserModel user) {

      dateOfBirth = DateFormat('yyyy-MM-dd').parse(user.birthdate!);
      now = DateTime.now();
      ageDuration = now.difference(dateOfBirth);
      ageYears = ageDuration.inDays ~/ 365;

      return Container(
        height: 55,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        decoration: BoxDecoration(
            color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: user.profilePhotoPath != null
                    ? Image.network(
                  '$baseUrlImage${user.profilePhotoPath}',
                  fit: BoxFit.cover,
                  width: 38,
                  height: 38,
                )
                    : Icon(Icons.person_sharp, color: Colors.black26, size: 30, ),
              ),
              const SizedBox(width: 15),
              Text(
                "${user.name}, ${ageYears}th",
                style: textButtonTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 0.1),
              user.gender == 'male' ?
              Image.asset(
                'assets/icon_male_white.png',
                width: 18,
                height: 18,
              ): user.gender == 'female' ?
              Image.asset(
                'assets/icon_female_white.png',
                width: 18,
                height: 18,
              ): Container(),
              const SizedBox(width: 69),
              // SvgPicture.asset(
              //   "assets/svg/icon_chat_blue.svg",
              //   width: 13,
              //   height: 13,
              // ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            search(),
            Expanded(
              child: ListView(
                  children: userFavorite.map((user) => yourname(user)).toList()
              )
            ),
          ],
        ),
      ),
    );
  }
}
