import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winwin/data/models/favorite_model.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/main_page.dart';
//import 'package:winwin/pages/main_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winwin/pages/profile/profile_details.dart';
import 'package:winwin/pages/widgets/avatar_custom.dart';

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
  String outputName = '';

  void iniState() {
    super.initState();

    UserData.loadUser();
    users = UserBloc.userList;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    users = UserBloc.userList;
    // print("user fav: ${user!.favorite!.length}");
    // print("users fav: ${users.length}");

    List<UserModel> userFavorite = user!.favorite!
        .map((favorite) =>
            users.where((user) => favorite.userFavoriteId == user.id).toList())
        .expand((element) => element)
        .toList();

    // print("user favorit: ${userFavorite.length}");

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

    Widget yourname(UserModel userFavorite) {
      dateOfBirth = DateFormat('yyyy-MM-dd').parse(userFavorite.birthdate!);
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
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileDetailsPage(user: userFavorite,)));
                },
                child: Container(
                  child: ClipOval(
                      child: userFavorite.profilePhotoPath != null
                          ? Image.network(
                              '$baseUrlImage${userFavorite.profilePhotoPath}',
                              fit: BoxFit.cover,
                              width: 38,
                              height: 38,
                            )
                          : AvatarCustom(
                              user: userFavorite,
                              width: 38,
                              height: 38,
                              color: Color(0xff85C5FFFF),
                              fontSize: 14,
                            )),
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileDetailsPage(user: userFavorite,)));
                },
                child: Text(
                  "${userFavorite.username}, ${ageYears}th",
                  style: textButtonTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(width: 0.1),
              userFavorite.gender == 'male'
                  ? Image.asset(
                      'assets/icon_male_white.png',
                      width: 18,
                      height: 18,
                    )
                  : userFavorite.gender == 'female'
                      ? Image.asset(
                          'assets/icon_female_white.png',
                          width: 18,
                          height: 18,
                        )
                      : Container(),
              const Spacer(),
              userFavorite.favorite!
                      .any((element) => element.userFavoriteId == user!.id)
                  ? IconButton(
                      onPressed: () {
                        // print("tap chat");
                        _launchInBrowser(
                            Uri.parse('https://wa.me/62${userFavorite.phoneNumber}'));
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/icon_chat_blue.svg",
                        width: 13,
                        height: 13,
                        color: textColor2,
                      ),
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/svg/icon_chat_blue.svg",
                        width: 13,
                        height: 13,
                        color: Color(0xffAFAFAFFF),
                      ),
                    )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: userFavorite.length >= 1
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  children: [
                    // search(),
                    Expanded(
                        child: ListView(
                            children: userFavorite
                                .map((user) => yourname(user))
                                .toList()))
                  ],
                ),
              )
            : Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_off_sharp,
                      size: 150,
                      color: appBarColor,
                    ),
                    Text(
                      "Hey ${user!.name}!! You've never saved anyone",
                      style: textSecondaryTextStyle.copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
