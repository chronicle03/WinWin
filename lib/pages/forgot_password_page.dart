import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/pages/widgets/loading_button.dart";
import 'constant.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController(text: '');
  //bool isForgot = true;
  String message = "null";

  @override
  Widget build(BuildContext context) {
    handleForgotPassword() {
      if (emailController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.yellow,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text("Field Must Be filled"),
          ),
        );
      } else if (message != "null") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(message),
          ),
        );
      }

      BlocProvider.of<UserBloc>(context).add(UserPostForgotPassword(
        emailController.text,
      ));
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 25),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/icon_row_left.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
                Text(
                  "Back to Login",
                  style: textColor1TextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
        ),
      );
    }

    Widget emailInput() {
      return Container(
        width: 300,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
            color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Row(
            children: [
              Image.asset(
                "assets/icon_email.png",
                width: 26,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: TextFormField(
                controller: emailController,
                style: textColor2TextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: "Email Address",
                    hintStyle: textColor2TextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500)),
              )),
            ],
          ),
        ),
      );
    }

    Widget buttonForgot() {
      return Container(
        width: 200,
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Reset Password', 
                                style: textColor1TextStyle.copyWith(
                                fontSize: 17,
                                fontWeight: semibold,
                                decoration: TextDecoration.none)),
                  content: Text('We have sent a link to your email, please check your email to reset your password.'),
                  backgroundColor: Colors.green,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            handleForgotPassword();
          },
          child: Text(
            "Reset Password",
            style: textButtonTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}


      Widget contentMerge(UserState state) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    header(),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 120),
                          Image.asset(
                            "assets/icon_forgot_password.png",
                            width: 160,
                            height: 160,
                          ),
                          Text(
                            "Please input your email to reset password",
                            style: textColor1TextStyle.copyWith(
                              fontSize: 17,
                              fontWeight: semibold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 23),
                          emailInput(),
                          const SizedBox(height: 13),
                          state is UserPostLoading
                              ? LoadingButton(
                            width: 200,
                          )
                              : buttonForgot(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }


    return Scaffold(
        backgroundColor: backgroundColor,
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserPostError) {
              message = state.code;
              print("message: $message");
            } else if (state is UserPostSuccess) {
              //isForgot = false;
              print("We have sent link to your email, please check your email to reset password");
              return contentMerge(state);
            }

            return contentMerge(state);
          },
        ));
  }
}