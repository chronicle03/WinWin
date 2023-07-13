import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/pages/widgets/loading_button.dart";
import "package:winwin/pages/widgets/snackbar.dart";
import "constant.dart";

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  TextEditingController emailController = TextEditingController(text: '');
  bool isResend = false;
  String message = "null";

  @override
  Widget build(BuildContext context) {
    handleResendVerifyEmail() {
      BlocProvider.of<UserBloc>(context).add(UserPostResendEmailVerify(
        emailController.text,
      ));
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 13),
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              "assets/icon_row_left.png",
              width: 24,
              height: 24,
            ),
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

    Widget buttonBackToLogin() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fixedSize: Size(double.infinity, 55), // Menyesuaikan lebar
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            "Continue to Login",
            style: textButtonTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          const SizedBox(height: 139),
          Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Image.asset(
                  "assets/icon_email_verify.png",
                  width: 160,
                  height: 160,
                ),
                const SizedBox(height: 23),
                Text("Please Check Your Email",
                    style: textColor1TextStyle.copyWith(
                        fontSize: 17,
                        fontWeight: semibold,
                        decoration: TextDecoration.none)),
                const SizedBox(height: 3),
                Text("We have sent link to you@example.com",
                    style: textSecondaryTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                        decoration: TextDecoration.none)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn’t receive link? ",
                        style: textSecondaryTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                            decoration: TextDecoration.none)),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isResend = true;
                          });
                        },
                        child: Text("Resend",
                            style: textColor1TextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: semibold,
                                color: textColor3,
                                decoration: TextDecoration.none))),
                  ],
                ),
                buttonBackToLogin(),
              ])),
        ],
      );
    }

    Widget buttonResend() {
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
            if (emailController.text == "") {
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                color: Colors.orangeAccent,
                icon: Icons.warning,
                message: "Email must be filled!",
              ));
            }else{
              handleResendVerifyEmail();
            }
          },
          child: Text(
            "Resend",
            style: textButtonTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    Widget contentMerge(UserState state) {
      return SafeArea(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    header(),
                    isResend
                        ? Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 120),
                                Image.asset(
                                  "assets/icon_email_verify.png",
                                  width: 160,
                                  height: 160,
                                ),
                                const SizedBox(height: 23),
                                emailInput(),
                                const SizedBox(height: 13),
                                state is UserPostLoading
                                    ? LoadingButton(
                                        width: 200,
                                      )
                                    : buttonResend()
                              ],
                            ),
                          )
                        : content(),
                  ],
                )),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserPostError) {
              message = state.code;
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                color: Colors.red,
                icon: Icons.warning,
                message: message,
              ));
            } else if (state is UserPostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                color: Colors.green,
                icon: Icons.check,
                message: "Resend Success, please check your email!",
              ));
              isResend = false;
              // return contentMerge(state);
            }
          },
          builder: (context, state) {
            return contentMerge(state);
          },
        ));
  }
}
