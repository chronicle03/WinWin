import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:swipeable_cards_stack/swipeable_cards_stack.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/models/user_model.dart";
import "package:winwin/data/repository/user_repository.dart";
import "package:winwin/data/singleton/user_data.dart";
import "package:winwin/pages/home/summary_profile.dart";
import "package:winwin/pages/notification/notification_page.dart";
import "package:winwin/pages/landing/landing_page.dart";

import "../../bloc/favorite_bloc.dart";
import "../constant.dart";
import "../widgets/input/skill_select_home.dart";

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserBloc _userBloc;
  List<String> skillSelect = [];
  UserModel? user = UserData.user;

  List<UserModel> users = [];
  List<UserModel> filteredUsers = [];

  bool isFavoriteTap = false;
  bool isSkipTap = false;

  var i = 0;

  final _cardController = SwipeableCardsStackController();

  @override
  void initState() {
    super.initState();
    // _userBloc = BlocProvider.of<UserBloc>(context);
    // _userBloc.add(GetUsers());
    UserData.loadUser();
    users = UserBloc.userList;
    filterUsers();
  }

  void updateSelectSkills(List<String> skills) {
    setState(() {
      skillSelect = skills;
      filterUsers();
      // print("filter user1 : ${filteredUsers.length}");
      buildCardStack();
    });
  }

  void filterUsers() {
    List<UserModel> userFavorite = user!.favorite!
        .map((favorite) =>
        users.where((user) => favorite.userFavoriteId == user.id).toList())
        .expand((element) => element)
        .toList();

    print("skill : $skillSelect");
    print("users : $skillSelect");

    setState(() {
      filteredUsers = users
          .where((element) =>
      element.id != user?.id &&
          !userFavorite.any((favorite) => favorite.id == element.id) &&
          (skillSelect.isEmpty ||
              element.ability!.any((ability) => ability.skills!
                  .any((skill) => skillSelect.contains(skill.name)))))
          .toList();
    });

    print("filter user2 : ${filteredUsers.length}");
  }

  Widget buildCardStack() {
    // filterUsers();
    return SwipeableCardsStack(
      cardController: _cardController,
      cardHeightTopMul: 0.75,
      cardHeightBottomMul: 0.5,
      context: context,
      onCardSwiped: (dir, index, widget) {
        if (dir == AxisDirection.right) {
          BlocProvider.of<FavoriteBloc>(context).add(
            FavoritePostCreate(
              user!.id!,
              widget.user.id,
            ),
          );
          setState(() {
            isFavoriteTap = true;
          });

          Timer(Duration(milliseconds: 400), () {
            setState(() {
              isFavoriteTap = false;
            });
          });
        }

        if (dir == AxisDirection.left) {
          setState(() {
            isSkipTap = true;
            filteredUsers
                .map((e) => print("filter user length: ${e.name}"))
                .toList();
          });

          Timer(Duration(milliseconds: 400), () {
            setState(() {
              isSkipTap = false;
            });
          });
        }

        if (index < filteredUsers.length - 1) {
          _cardController.addItem(
            SummaryProfileWidget(user: filteredUsers[index + 1]),
          );
        }

      },
      enableSwipeUp: false,
      enableSwipeDown: false,
      items: filteredUsers.map((e) => SummaryProfileWidget(user: e)).toList(),
    );
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: user?.profilePhotoPath != null
                ? Image.network(
                    '$baseUrlImage${user!.profilePhotoPath}',
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  )
                : Icon(Icons.person_sharp, color: Colors.black26, size: 30, ),
          ),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${user!.username}",
                    style: textColor1TextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(width: 4),
                  user!.gender == 'male'
                      ? Image.asset(
                          'assets/icon_male_white.png',
                          width: 18,
                          height: 18,
                        )
                      : user!.gender == 'female'
                          ? Image.asset(
                              'assets/icon_female_white.png',
                              width: 18,
                              height: 18,
                            )
                          : Container(),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Image.asset(
                    "assets/icon_location.png",
                    width: 8,
                    height: 11,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${user!.location}",
                    style: textSecondaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // SkillSelectHome(updateSelectSkills),
          // Image.asset("assets/svg/icon_filter.svg", width: 50, height: 50),
          const SizedBox(width: 6),
          // InkResponse(
          //   highlightShape: BoxShape.circle,
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => NotificationPage()));
          //   },
          //   splashColor: Colors.black.withOpacity(0.1), // Warna efek splash
          //   radius: 32,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.15),
          //           offset: Offset(0, 2),
          //           blurRadius: 4,
          //           spreadRadius: -3,
          //         ),
          //       ],
          //     ),
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => NotificationPage()));
          //       },
          //       child: SvgPicture.asset(
          //         'assets/svg/icon_notif.svg',
          //         width: 50,
          //         height: 50,
          //       ),
          //     ),
          //   ),
          // ),
          // Image.asset("assets/svg/icon_notif.svg", width: 50, height: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(top: 53, bottom: 20),
        child: Column(
          children: [
            header(),
            buildCardStack(),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () => {
                      _cardController.triggerSwipeLeft(),
                      setState(() {
                        isSkipTap = true;
                      }),
                    },
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        isSkipTap
                            ? 'assets/svg/icon_skip_tap.svg'
                            : 'assets/svg/icon_skip.svg',
                        width: 57,
                        height: 57,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _cardController.triggerSwipeRight();
                      setState(() {
                        isFavoriteTap = true;
                      });
                    },
                    backgroundColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        isFavoriteTap
                            ? 'assets/svg/icon_favorite_tap.svg'
                            : 'assets/svg/icon_favorite.svg',
                        width: 57,
                        height: 57,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
