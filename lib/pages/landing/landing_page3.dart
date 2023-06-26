import "dart:async";

import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/landing/landing_page4.dart";

class LandingPage3 extends StatefulWidget {
  const LandingPage3({Key? key}) : super(key: key);

  @override
  State<LandingPage3> createState() => _LandingPage3State();
}

class _LandingPage3State extends State<LandingPage3> {
  bool isSkip = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 5), () {
      if (!isSkip) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage4()),
        );
      }
    });
  }

   void _navigateToLoginPage() {
    setState(() {
      isSkip = true;
    });
    _timer.cancel();
    Navigator.pushNamed(context, '/login').then((_) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        // Kembali ke halaman ini setelah login
        setState(() {
          isSkip = false;
        });
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomingPage3Input() {
      return Container(
        padding: EdgeInsets.only(top: 130, left: 25, right: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/wp3.png',
                height: 237,
                width: 237,
              ),
            ),
            const SizedBox(height: 105),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Build Your Social",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Relations",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Build valuable friendships, mentorships,",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "or professional connections.",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/lingkaran-2.png',
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
                        onPressed: () {
                          _navigateToLoginPage();
                        },
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
            const SizedBox(height: 44),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          welcomingPage3Input(),
        ],
      ),
    );
  }
}
