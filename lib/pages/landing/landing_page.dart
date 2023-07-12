import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/landing/landing_page2.dart";

import "../../bloc/skill_bloc.dart";
import "../../data/singleton/user_data.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // late UserBloc _userBloc;
  late UserBloc _userBloc;
  late SkillBloc _skillBloc;

  @override
  void initState() {
    super.initState();
    // clearPreference();

    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUsers()); // Memanggil event GetUsers untuk memuat daftar pengguna

    _skillBloc = BlocProvider.of<SkillBloc>(context);
    _skillBloc.add(GetSkillEvent());
    checkFirstLaunch();
    UserData.loadUser();
  }

  void checkFirstLaunch() async {

    bool isFirstLaunch = await getFirstLaunch();
    // UserData.user = await getUser();
    String token = await getToken();
    print("token landing: $token");

    if (!isFirstLaunch) {
      setFirstLaunch(true);
      Future.delayed(Duration(seconds: 10), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage2()),
        );
      });
    } else {
      if (token != '') {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.pushReplacementNamed(
            context,
            '/home',
          );
        });
      } else {
        Navigator.pushNamed(
          context,
          '/login',
        );
      }
    }
  }

  clearPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setFirstLaunch(bool isTrue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstLaunch', isTrue);
  }

  Future<bool> getFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
    return isFirstLaunch ?? true;
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    return isLogin ?? true;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 100, left: 57, right: 21),
            child: Column(
              children: [
                Image.asset(
                  'assets/Logo.png',
                  height: 282,
                  width: 282,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 200),
            child: CircularProgressIndicator(color: buttonColor),
          ),
        ],
      ),
    );
  }
}
