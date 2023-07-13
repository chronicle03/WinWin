import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
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

import "bloc/favorite_bloc.dart";
import "bloc/skill_bloc.dart";
import "data/repository/favorite_repository.dart";
import "data/repository/skill_repository.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  final SkillRepositoryImpl skillRepository = SkillRepositoryImpl();
  final FavoriteRepositoryImpl favoriteRepository = FavoriteRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
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
        '/home': (context) =>  MultiBlocProvider(providers: [
          BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository)),
          BlocProvider<FavoriteBloc>(
              create: (context) => FavoriteBloc(favoriteRepository)),
        ], child: MainPage()),
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
