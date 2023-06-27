import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';

class NotificationPage2 extends StatefulWidget {
  const NotificationPage2({Key? key}) : super(key: key);

  @override
  State<NotificationPage2> createState() => _NotificationPage2State();
}

class _NotificationPage2State extends State<NotificationPage2> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 60),
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
        ),
      );
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          header(),
          Container(
            width: 310,
            height: 35,
            margin: EdgeInsets.only(top: 5, right: 25, left: 25),
            padding: EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
              color: appBarColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/icon_search.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    style: textColor2TextStyle.copyWith(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: "Find contact you want to search for",
                      hintStyle: textColor2TextStyle.copyWith(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                'assets/icon_notif_empty.png',
                height: 282,
                width: 282,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Notification",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "You don't have notifications right now.\nCome back later.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ],
    ),
  );
}
}
