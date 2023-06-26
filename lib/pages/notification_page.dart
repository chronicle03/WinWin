import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget{
  const NotificationPage({super.key});
   @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          const SizedBox(height: 13),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/icon_row_left.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
                Text(
                  "Notifications",
                  style: textColor1TextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }
    Widget search() {
      return Container(
          width: 310,
          height: 35,
          margin: EdgeInsets.only(top: 5, right: 25, left: 25),
          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(children: [
            Image.asset(
              "assets/icon_search.png",
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

      Widget today(){
        return Container(
          height: 55,
          width: 340,
          margin: const EdgeInsets.only(top: 18.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Today",
              style: textColor1TextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor3,
              ),
            ),
          ),
        );
      } 

      Widget yesterday(){
        return Container(
          height: 55,
          width: 340,
          margin: const EdgeInsets.only(top: 18.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Yesterday",
              style: textColor1TextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor3,
              ),
            ),
          ),
        );
      } 

      Widget notif1() {
        return Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Your Name 1 is interested in exchanging skills with you. Don't miss this oppor...",
                    style: textButtonTextStyle.copyWith(
                      fontSize: 11,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "19.40",
                      style: textColor1TextStyle.copyWith(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 1.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "match",
                        style: textColor2TextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      Widget notif2() {
        return Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Read the latest reviews about your skills! Other users appreciate your ex...",
                    style: textButtonTextStyle.copyWith(
                      fontSize: 11,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "19.40",
                      style: textColor1TextStyle.copyWith(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 1.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "match",
                        style: textColor2TextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      Widget notif3() {
        return Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Enhance your profile by adding experiences and showcasing your portfolio...",
                    style: textButtonTextStyle.copyWith(
                      fontSize: 11,
                      color: textColor2,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "19.40",
                      style: textColor1TextStyle.copyWith(
                        fontSize: 11,
                        color: textColor2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 1.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "match",
                        style: textColor2TextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    
    Widget notif4() {
        return Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "New skills have been added to the categories you follow. Explore and expa...",
                    style: textButtonTextStyle.copyWith(
                      fontSize: 11,
                      color: textColor2,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "19.40",
                      style: textColor1TextStyle.copyWith(
                        fontSize: 11,
                        color: textColor2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 1.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "winwin",
                        style: textColor2TextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
    }
    Widget notif5() {
        return Container(
          height: 55,
          width: 310,
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Congratulations, you have successfully created an account.",
                    style: textButtonTextStyle.copyWith(
                      fontSize: 11,
                      color: textColor2,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "19.40",
                      style: textColor1TextStyle.copyWith(
                        fontSize: 11,
                        color: textColor2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 1.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "winwin",
                        style: textColor2TextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
          header(),
          search(),
          today(),
          notif1(),
          notif2(),
          notif3(),
          yesterday(),
          notif4(),
          notif5(),
      ],
      ),
    );
  }
  


}