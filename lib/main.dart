import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/repository/user_repository.dart";
import "package:winwin/pages/home/home_page.dart";
import "package:winwin/pages/landing_page.dart";
import "package:winwin/pages/login_page.dart";
import "package:winwin/pages/register_page.dart";

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
        '/home': (context) => HomePage(),
        '/register': (context) => BlocProvider(
          create: (context) => UserBloc(userRepository),
          child: RegisterPage(),
        ),
      },
    );
  }
}
