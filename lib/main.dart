import "package:flutter/material.dart";
import "package:winwin/pages/home/home_page.dart";
import "package:winwin/pages/register_page.dart";
import "package:winwin/validasi_register/validasi_register_form.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ValidasiForm(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
