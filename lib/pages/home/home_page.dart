import "dart:async";
import "dart:convert";
import "dart:developer";

import "package:appinio_swiper/appinio_swiper.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";
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
import "../widgets/avatar_custom.dart";
import "../widgets/input/skill_select_home.dart";
import "../winwin-matching.dart";

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
  bool isEnd = false;
  bool isSkillSelect = false;


  var i = 0;

  final AppinioSwiperController controller = AppinioSwiperController();

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUsers()); // Memanggil event GetUsers untuk memuat daftar pengguna

    UserData.loadUser();
    users = UserBloc.userList;
    filterUsers();
  }

  void updateSelectSkills(List<String> skills) {
    setState(() {
      skillSelect = skills;
      filterUsers();
    });
  }

  filterUsers(){
    List<UserModel> userFavorite = user!.favorite!
        .map((favorite) => users.firstWhere((user) => favorite.userFavoriteId == user.id, orElse: () => UserModel()))
        .toList();

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

    if(filteredUsers.length == 0 && skillSelect.length >= 1){
      setState(() {
        isSkillSelect = true;
      });
    }else {
      setState(() {
        isSkillSelect = false;
      });
    }

    print("filter user2 : ${filteredUsers.length}");
    return filteredUsers;
  }

  void _swipe(int index, AppinioSwiperDirection direction) async{
    if (direction.name == 'left') {
      if (isSkipTap == false) {
        setState(() {
          isSkipTap = true;
        });
        await Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            isSkipTap = false;
          });
        });
      } else {
        setState(() {
          isSkipTap = false;
        });
      }
    } else if (direction.name == 'right') {
      // print("index swipe: $index");
      _userBloc = BlocProvider.of<UserBloc>(context);
      _userBloc.add(GetUsers());

      // Introduce a slight delay using Future.delayed
      // await Future.delayed(Duration(milliseconds: 100));

      if (index == 0) {
        BlocProvider.of<FavoriteBloc>(context).add(
          FavoritePostCreate(user!.id!, filteredUsers.last.id!),
        );
        print("isMatch?");
        if (filteredUsers.last.favorite!.any((element) => element.userFavoriteId == user!.id)) {
          print("match");
          Navigator.push(context, MaterialPageRoute(builder: (context) => MatchingPage(user!, filteredUsers.last)));
        } else {
          print("not Match");
        }
      } else {
        print("index: ${filteredUsers[index - 1].id!}, ${filteredUsers[index - 1].name!}");
        BlocProvider.of<FavoriteBloc>(context).add(
          FavoritePostCreate(user!.id!, filteredUsers[index - 1].id!),
        );
        print("isMatch?");
        if (filteredUsers[index - 1].favorite!.any((element) => element.userFavoriteId == user!.id)) {
          print("start match");
          print("match");
          Navigator.push(context, MaterialPageRoute(builder: (context) => MatchingPage(user!, filteredUsers[index - 1])));
        } else {
          print("not Match");
        }
      }

      setState(() {
        filteredUsers = filterUsers();
      });

      if (isFavoriteTap == false) {
        setState(() {
          isFavoriteTap = true;
        });
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            isFavoriteTap = false;
          });
        });
      } else {
        setState(() {
          isFavoriteTap = false;
        });
      }
    }
  }

  void _unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }

  _onEnd() {
    log("end reached!");
    setState(() {
      isEnd = true;
    });
  }

  Widget appinioSwiperWidget(List<UserModel> filteredUsers) {
    return AppinioSwiper(
      // loop: true,
      swipeOptions: const AppinioSwipeOptions.all(),
      // unlimitedUnswipe: true,
      controller: controller,
      unswipe: _unswipe,
      onSwiping: (AppinioSwiperDirection direction) {
        // print("dir: $direction");
        debugPrint(direction.toString());
      },
      onSwipe: _swipe,
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 30,
        bottom: 20,
      ),
      onEnd: _onEnd,
      cardsCount: filteredUsers.length,
      cardsBuilder: (BuildContext context, int index) {
        UserModel user = filteredUsers[index];
        return SummaryProfileWidget(userModel: user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: appBarColor,
                  width: 5.0,
                ),
              ),
              child: ClipOval(
                child: user?.profilePhotoPath != null
                    ? Image.network(
                  '$baseUrlImage${user!.profilePhotoPath}',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                )
                    : AvatarCustom(
          user: user!, width: 50, height: 50, color: appBarColor, fontSize: 18,),
              ),
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
                      user!.location ?? "Indonesia" ,
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
            SkillSelectHome(updateSelectSkills),
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(top: 53, bottom: 20),
        child: Column(
          children: [
            header(),
            isEnd?
                Container(
                  margin: EdgeInsets.only(top: 200),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Horray!!! you have reached all users, please reopen winwin in a few moments",
                    style: textSecondaryTextStyle.copyWith(
                      fontSize: 25
                    ),
                    textAlign: TextAlign.center,
                  ),
                ) : isSkillSelect ?  Container(
              margin: EdgeInsets.only(top: 200),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Sorry, the user with the skill you selected has not been found",
                style: textSecondaryTextStyle.copyWith(
                    fontSize: 25
                ),
                textAlign: TextAlign.center,
              ),
            )
            : filteredUsers.isNotEmpty ? Expanded(
              child: Stack(
                children: [
                  appinioSwiperWidget(filteredUsers),
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () => {
                              controller.swipeLeft(),
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
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            onPressed: () {
                              controller.swipeRight();
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
                  )
                ],
              ),
            ) : Container(
              margin: EdgeInsets.only(top: 200),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Horray!!! you have reached all users, please reopen winwin in a few moments",
                style: textSecondaryTextStyle.copyWith(
                    fontSize: 25
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
