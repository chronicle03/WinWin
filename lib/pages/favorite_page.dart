import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/main_page.dart';
//import 'package:winwin/pages/main_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget search() {
      return Container(
          width: double.infinity,
          height: 35,
          margin: EdgeInsets.only(top: 55, bottom: 20),
          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
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
          width:double.infinity,
          margin: const EdgeInsets.only(top: 10.0),
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
return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
          search(),
          Expanded(
            child: ListView(
              children: [
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
                yourname(),
              ],
            ),
          ),
            
        ],
        ),
      ),
    );
  }
}
