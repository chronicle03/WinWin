import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:swipeable_cards_stack/swipeable_cards_stack.dart";
import "package:winwin/data/models/user_model.dart";
import "package:winwin/pages/home/summary_profile.dart";
import "package:winwin/pages/notif_page.dart";

import "../constant.dart";

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _cardController = SwipeableCardsStackController();
 List<UserModel> users = [
  UserModel(
    id: 1,
    name: "John Doe",
    email: "johndoe@example.com",
    username: "johndoe",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "New York",
    phoneNumber: "+1 1234567890",
    birthdate: "1990-01-01",
    profilePhotoUrl: "assets/john_mayer.jpg",
    token: "dummy_token_1",
  ),
  UserModel(
    id: 2,
    name: "Jane Smith",
    email: "janesmith@example.com",
    username: "janesmith",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Los Angeles",
    phoneNumber: "+1 9876543210",
    birthdate: "1995-05-15",
    profilePhotoUrl: "assets/rose.jpg",
    token: "dummy_token_2",
  ),
  UserModel(
    id: 3,
    name: "Alice Johnson",
    email: "alicejohnson@example.com",
    username: "alicejohnson",
    bio: "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
    location: "Chicago",
    phoneNumber: "+1 5555555555",
    birthdate: "1985-12-10",
    profilePhotoUrl: "assets/john_mayer.jpg",
    token: "dummy_token_3",
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
          items: users.map((e) => SummaryProfileWidget(user: e, skill: ['guitar', 'music'])).toList(),
          onCardSwiped: (dir, index, widget) {
            // Add the next card using _cardController
            
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
                    'assets/svg/icon_skip.svg',
                    width: 57,
                    height: 57,
                  ),
                ),
              ),
              FloatingActionButton(
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
                    'assets/svg/icon_favorite.svg',
                    width: 57,
                    height: 57,
                  ),
                ),
                onPressed: () => _cardController.triggerSwipeRight(),
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
