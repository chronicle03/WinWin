import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/repository/user_repository.dart";
import "package:winwin/pages/about.dart";
import "package:winwin/pages/landing/landing_page.dart";
import "package:winwin/pages/login_page.dart";
import "package:winwin/pages/main_page.dart";
import "package:winwin/pages/profile/edit_profile.dart";
import "package:winwin/pages/profile/profile_settings_page.dart";
import "package:winwin/pages/register_page.dart";
import "package:winwin/pages/verify_email_page.dart";

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
        '/': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: LandingPage(),
            ),
         '/edit-profile':(context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: EditProfilePage(),
            ),
        '/login': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: LoginPage(),
            ),
        '/resend-verify-email': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: VerifyEmailPage(),
            ),
        '/home': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: MainPage(0),
            ),
        '/register': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: RegisterPage(),
            ),
        '/about': (context) => About(),
       
      },
    );
  }
}