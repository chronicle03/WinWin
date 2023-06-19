import "package:flutter/material.dart";
import "package:winwin/pages/home/home_page.dart";
import "package:winwin/pages/login_page.dart";
import "package:winwin/pages/register_page.dart";
import "package:winwin/validasi_login/validasi_login.dart";


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SuccesLogin(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

