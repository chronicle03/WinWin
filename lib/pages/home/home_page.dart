import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:swipeable_cards_stack/swipeable_cards_stack.dart";
import "package:winwin/data/models/user_model.dart";
import "package:winwin/pages/home/summary_profile.dart";
import "package:winwin/pages/notif_page.dart";

import "../constant.dart";

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFavoriteTap = false;

  bool isSkipTap = false;
  var i = 3;

  final _cardController = SwipeableCardsStackController();

  List<UserModel> users = [
  UserModel(
    id: 1,
    name: "Alice Johnson",
    email: "alicejohnson@example.com",
    username: "alicejohnson",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Chicago",
    phoneNumber: "+1 5555555555",
    birthdate: "1985-12-10",
    profilePhotoUrl: "assets/john_mayer.jpg",
    token: "dummy_token_1",
  ),
  UserModel(
    id: 2,
    name: "John Smith",
    email: "johnsmith@example.com",
    username: "johnsmith",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "New York",
    phoneNumber: "+1 5555555555",
    birthdate: "1990-05-15",
    profilePhotoUrl: "assets/coding.jpg",
    token: "dummy_token_2",
  ),
  UserModel(
    id: 3,
    name: "Bob Williams",
    email: "bobwilliams@example.com",
    username: "bobwilliams",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Los Angeles",
    phoneNumber: "+1 5555555555",
    birthdate: "1987-07-20",
    profilePhotoUrl: "assets/picture2.jpg",
    token: "dummy_token_3",
  ),
  UserModel(
    id: 4,
    name: "Sarah Davis",
    email: "sarahdavis@example.com",
    username: "sarahdavis",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "San Francisco",
    phoneNumber: "+1 5555555555",
    birthdate: "1992-03-18",
    profilePhotoUrl: "assets/picture1.jpg",
    token: "dummy_token_4",
  ),
  UserModel(
    id: 5,
    name: "Michael Johnson",
    email: "michaeljohnson@example.com",
    username: "michaeljohnson",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Miami",
    phoneNumber: "+1 5555555555",
    birthdate: "1984-09-26",
    profilePhotoUrl: "assets/picture3.jpeg",
    token: "dummy_token_5",
  ),
  UserModel(
    id: 6,
    name: "Emily Wilson",
    email: "emilywilson@example.com",
    username: "emilywilson",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Seattle",
    phoneNumber: "+1 5555555555",
    birthdate: "1993-11-05",
    profilePhotoUrl: "assets/picture4.jpeg",
    token: "dummy_token_6",
  ),
  UserModel(
    id: 7,
    name: "David Thompson",
    email: "davidthompson@example.com",
    username: "davidthompson",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Denver",
    phoneNumber: "+1 5555555555",
    birthdate: "1989-06-12",
    profilePhotoUrl: "assets/picture5.jpg",
    token: "dummy_token_7",
  ),
  UserModel(
    id: 8,
    name: "Olivia Harris",
    email: "oliviaharris@example.com",
    username: "oliviaharris",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Boston",
    phoneNumber: "+1 5555555555",
    birthdate: "1991-08-30",
    profilePhotoUrl: "assets/rose.jpg",
    token: "dummy_token_8",
  ),
  UserModel(
    id: 9,
    name: "Daniel Martin",
    email: "danielmartin@example.com",
    username: "danielmartin",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Houston",
    phoneNumber: "+1 5555555555",
    birthdate: "1988-02-22",
    profilePhotoUrl: "assets/picture6.jpeg",
    token: "dummy_token_9",
  ),
  UserModel(
    id: 10,
    name: "Sophia Thompson",
    email: "sophiathompson@example.com",
    username: "sophiathompson",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Austin",
    phoneNumber: "+1 5555555555",
    birthdate: "1994-07-08",
    profilePhotoUrl: "assets/picture1.jpg",
    token: "dummy_token_10",
  ),
];

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/rose.jpg',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(width: 9),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Hi, Your Name",
                      style: textColor1TextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 4),
                    Image.asset(
                      'assets/icon_female.png',
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
                      "Location Unknown",
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotifPage()));
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
                child: SvgPicture.asset(
                  'assets/svg/icon_notif.svg',
                  width: 50,
                  height: 50,
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
                  .map((e) =>
                      SummaryProfileWidget(user: e, skill: ['guitar', 'music']))
                  .toList(),
              onCardSwiped: (dir, index, widget) {
                // Add the next card using _cardController
                
                 if (i < users.length) {
                  print(i);
                  print(users[i].name);
                   _cardController.addItem(SummaryProfileWidget(user: users[i], skill: ['guitar', 'music']));
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
