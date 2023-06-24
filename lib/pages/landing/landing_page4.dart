import "dart:async";

import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/login_page.dart";

class LandingPage4 extends StatefulWidget {
  const LandingPage4({Key? key}) : super(key: key);

  @override
  State<LandingPage4> createState() => _LandingPage4State();
}

class _LandingPage4State extends State<LandingPage4> {
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
          MaterialPageRoute(builder: (context) => LoginPage()),
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
    Widget welcomingPage4Input() {
      return Container(
        padding: EdgeInsets.only(top: 70, left: 61, right: 62),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/wp4.png',
                height: 176,
                width: 244,
              ),
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Join Us and Star",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Journey!",
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
                    "Register now to become part of our",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "community and start your journey",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "towards building valuable relationships",
                    style: textColor1TextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "with fellow users.",
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
                      'assets/lingkaran-3.png',
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
          welcomingPage4Input(),
        ],
      ),
    );
  }
}
