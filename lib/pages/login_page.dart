import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:winwin/pages/constant.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Widget emailAddressInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "../assets/icon_email.svg",
                      width: 26,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: textColor1TextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "Email Address",
                          hintStyle: textColor2TextStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "../assets/icon_password.svg",
                      width: 35,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: textColor1TextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "Password",
                          hintStyle: textColor2TextStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    )),
                    SvgPicture.asset(
                      "../assets/icon_eye_close.svg",
                      width: 26,
                      height: 23,
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 13),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "../assets/icon_row_left.svg",
                        width: 24,
                        height: 24,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0)),
                      Text(
                        "Login",
                        style: textColor1TextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back!",
                    style: textColor1TextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please login to continue!",
                    style: textColor1TextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    emailAddressInput(),
                    passwordInput(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Forgot Password?",
                            style: textColor1TextStyle.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.symmetric(vertical: 14),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Login",
                      style: textButtonTextStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(height: 13),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 400),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: textColor1TextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                " Register Now",
                                style: textColor3TextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
