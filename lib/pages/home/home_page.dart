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

import "../constant.dart";

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserBloc _userBloc;
  UserModel? user;
  @override
  void initState() {
    super.initState();
    UserData.loadUser();
    user = UserData.user;
  }

  List<UserModel> users = [];

  bool isFavoriteTap = false;
  bool isSkipTap = false;

  var i = 0;

  final _cardController = SwipeableCardsStackController();

  @override
  Widget build(BuildContext context) {
    users = UserBloc.userList;

    try{
      print("user home: ${user?.email}");
    }catch (e){
      print("error: ${e}");
    }

    // users.map((e) => print("userList: ${e.name}")).toList();

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
                  : Image.asset(
                      'assets/photoProfile.png',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
            ),
            const SizedBox(width: 9),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hi, ${user!.name}",
                      style: textColor1TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 4),
                    Image.asset(
                      'assets/icon_male_white.png',
                      width: 18,
                      height: 18,
                    ),
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
            const SizedBox(width: 34),
            InkResponse(
              highlightShape: BoxShape.circle,
              onTap: () {
                // Aksi yang ingin dilakukan saat di-tap
              },
              splashColor: Colors.black.withOpacity(0.1), // Warna efek splash
              radius: 32,
              // borderRadius:
              //     BorderRadius.circular(10), // Membuat tepi menjadi lingkaran
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: -3,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/svg/icon_filter.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            // Image.asset("assets/svg/icon_filter.svg", width: 50, height: 50),
            const SizedBox(width: 6),
            InkResponse(
              highlightShape: BoxShape.circle,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
              splashColor: Colors.black.withOpacity(0.1), // Warna efek splash
              radius: 32,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: -3,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()));
                  },
                  child: SvgPicture.asset(
                    'assets/svg/icon_notif.svg',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
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
            SwipeableCardsStack(
              cardController: _cardController,
              cardHeightTopMul: 0.75,
              cardHeightBottomMul: 0.5,
              context: context,
              items: users
                  .where((element) => element.id != user?.id)
                  .map((e) => SummaryProfileWidget(user: e))
                  .toList(),
              onCardSwiped: (dir, index, widget) {
                // Add the next card using _cardController

                if (i < users.length) {
                  print(i);
                  print(users[i].name);
                  _cardController.addItem(SummaryProfileWidget(user: users[i]));
                  i++;
                }

                if (dir == AxisDirection.right) {
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
                  });

                  Timer(Duration(milliseconds: 400), () {
                    setState(() {
                      isSkipTap = false;
                    });
                  });
                }

                // Take action on the swiped widget based on the direction of swipe
                // Return false to not animate cards
              },
              enableSwipeUp: false,
              enableSwipeDown: false,
            ),
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
                    onPressed: () => _cardController.triggerSwipeLeft(),
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
