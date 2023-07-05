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
import 'package:winwin/pages/forgot_password_page.dart';
import "package:winwin/pages/verify_email_page.dart";

import "bloc/skill_bloc.dart";
import "data/repository/skill_repository.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  final SkillRepositoryImpl skillRepository = SkillRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MultiBlocProvider(providers: [
              BlocProvider<UserBloc>(
                  create: (context) => UserBloc(userRepository)),
              BlocProvider<SkillBloc>(
                  create: (context) => SkillBloc(skillRepository)),
            ], child: LandingPage()),
        '/edit-profile': (context) => MultiBlocProvider(providers: [
              BlocProvider<UserBloc>(
                create: (context) => UserBloc(userRepository)),
              BlocProvider<SkillBloc>(
                  create: (context) => SkillBloc(skillRepository)),
            ], child: EditProfilePage()),
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
        '/register': (context) => MultiBlocProvider(providers: [
          BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository)),
          BlocProvider<SkillBloc>(
              create: (context) => SkillBloc(skillRepository)),
        ], child: RegisterPage()),
        '/forgot-password': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: ForgotPasswordPage(),
            ),
        '/about': (context) => About(),
      },
    );
  }
}
