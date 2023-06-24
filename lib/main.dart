import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/repository/user_repository.dart";
import "package:winwin/pages/about.dart";
import "package:winwin/pages/home/home_page.dart";
import "package:winwin/pages/landing_page.dart";
import "package:winwin/pages/login_page.dart";
import "package:winwin/pages/validasi_login.dart";
import "package:winwin/pages/verify_email_page.dart";
import 'package:winwin/pages/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/resend-verify-email': (context) => BlocProvider(
              create: (context) => UserBloc(userRepository),
              child: VerifyEmailPage(),
            ),
        '/home': (context) => HomePage(),
        '/register': (context) => BlocProvider(
              create: (context) => UserBloc(userRepository),
            ),
        '/about': (context) => AboutPage(),
        '/validasi-login': (context) => ValidasiLogin(),
      },
    );
  }
}