import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';
//import 'package:winwin/pages/main_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget search() {
      return Container(
          width: 310,
          height: 35,
          margin: EdgeInsets.only(top: 55, right: 25, left: 25),
          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(children: [
            SvgPicture.asset(
              "assets/svg/icon_search.svg",
              width: 30,
              height: 30,
            ),
            SizedBox(width: 10,),
            Text(
              "Find contact you want to search for",
              style: textColor2TextStyle.copyWith(
                fontSize: 12,
                fontStyle: FontStyle.italic

              ),
            )
          ])
      );
    }
    Widget yourname() {
      return
        Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 30.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/john_mayer.jpg',
                    width: 38,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                    width: 15
                ),
                Text(
                  "Your Name 1, 22th",
                  style: textButtonTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                    width: 0.1
                ),
                SvgPicture.asset(
                  "assets/svg/icon_male.svg",
                  width: 13,
                  height: 13,
                ),
                const SizedBox(
                    width: 69
                ),
                SvgPicture.asset(
                  "assets/svg/icon_chat_blue.svg",
                  width: 13,
                  height: 13,
                ),
              ],
            ),
          ),
        );
    }

      Widget yourname2() {
        return
          Container(
            height: 55,
            width: 310,
            margin: const EdgeInsets.only(top: 30.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/picture2.jpg',
                      width: 38,
                      height: 38,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                      width: 15
                  ),
                  Text(
                    "Your Name 2, 25th",
                    style: textButtonTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                      width: 0.1
                  ),
                  SvgPicture.asset(
                    "assets/svg/icon_male.svg",
                    width: 13,
                    height: 13,
                  ),
                  const SizedBox(
                      width: 69
                  ),
                  SvgPicture.asset(
                    "assets/svg/icon_chat_blue.svg",
                    width: 13,
                    height: 13,
                  ),
                ],
              ),
            ),
          );
    }
    Widget yourname3() {
      return
        Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 30.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/picture5.jpg',
                    width: 38,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                    width: 15
                ),
                Text(
                  "Your Name 3, 20th",
                  style: textButtonTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                    width: 0.1
                ),
                SvgPicture.asset(
                  "assets/svg/icon_female.svg",
                  width: 13,
                  height: 13,
                ),
                const SizedBox(
                    width: 69
                ),
                SvgPicture.asset(
                  "assets/svg/icon_chat_blue.svg",
                  width: 13,
                  height: 13,
                ),
              ],
            ),
          ),
        );
    }
    Widget yourname4() {
      return
        Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 30.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/picture4.jpeg',
                    width: 38,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                    width: 15
                ),
                Text(
                  "Your Name 4, 22th",
                  style: textButtonTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                    width: 0.1
                ),
                SvgPicture.asset(
                  "assets/svg/icon_male.svg",
                  width: 13,
                  height: 13,
                ),
                const SizedBox(
                    width: 69
                ),
                SvgPicture.asset(
                  "assets/svg/icon_chat_blue.svg",
                  width: 13,
                  height: 13,
                ),
              ],
            ),
          ),
        );
    }
    Widget yourname5() {
      return
        Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 30.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/rose.jpg',
                    width: 38,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                    width: 15
                ),
                Text(
                  "Your Name 5, 23th",
                  style: textButtonTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                    width: 0.1
                ),
                SvgPicture.asset(
                  "assets/svg/icon_female.svg",
                  width: 13,
                  height: 13,
                ),
                const SizedBox(
                    width: 69
                ),
                SvgPicture.asset(
                  "assets/svg/icon_chat_blue.svg",
                  width: 13,
                  height: 13,
                ),
              ],
            ),
          ),
        );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
        search(),
        yourname(),
          yourname2(),
          yourname3(),
          yourname4(),
          yourname5(),
      ],
      ),
    );
  }
}