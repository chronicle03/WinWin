import "dart:async";

import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/landing/landing_page3.dart";

class LandingPage2 extends StatefulWidget {
  const LandingPage2({Key? key}) : super(key: key);

  @override
  State<LandingPage2> createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2> {
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
          MaterialPageRoute(builder: (context) => LandingPage3()),
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
    Widget welcomingPage2Input() {
      return Container(
        padding: EdgeInsets.only(top: 85, left: 61, right: 62),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/wp2.png',
                height: 237,
                width: 237,
              ),
            ),
            const SizedBox(height: 60),
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
            const SizedBox(height: 85),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/lingkaran-1.png',
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
          welcomingPage2Input(),
        ],
      ),
    );
  }
}
