import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/landing/landing_page2.dart";


class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 259, bottom: 259, left: 57, right: 21),
        child: Image.asset(
          'assets/Logo.png',
          height: 282,
          width: 282,
        ),
      ),
    );
  }
}
