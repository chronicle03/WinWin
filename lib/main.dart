
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
              child: RegisterPage(),
            ),
      },
    );
  }
}