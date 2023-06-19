import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Widget welcomingPage2Input() {
      return Container(
        padding: EdgeInsets.only(top: 129, left: 61, right: 62),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                '../assets/wp2.png',
                height: 282,
                width: 282,
              ),
            ),
            const SizedBox(height: 86),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Why WinWin?",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Improve your skills by trading",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "skills for free.",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 174),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      '../assets/lingkaran-1.png',
                      width: 59,
                      height: 15,
                    ),
                    Container(
                      width: 177,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Skip",
                          style: textButtonTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.only(top: 259, bottom: 259, left: 57, right: 21),
            child: Image.asset(
              '../assets/Logo.png',
              height: 282,
              width: 282,
            ),
          ),
          Column(
            children: [
              welcomingPage2Input(),
            ],
          ),
        ],
      ),
    );
  }
}
