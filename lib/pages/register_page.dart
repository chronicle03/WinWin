import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:winwin/pages/constant.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget fullNameInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "../assets/icon_profile_default.svg",
                      width: 26,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: textButtonTextStyle.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      decoration: InputDecoration.collapsed(
                          hintText: "Full Name",
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

    Widget userNameInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "../assets/icon_profile_add.svg",
                      width: 26,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: textButtonTextStyle.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      decoration: InputDecoration.collapsed(
                          hintText: "Username",
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

    Widget dateOfBirthInput() {
      return InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Row(
              children: [
                SvgPicture.asset(
                  "../assets/icon_calendar.svg",
                  width: 26,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                      selectedDate != null
                          ? selectedDate.toString()
                          : 'Date of Birth',
                      style: textColor2TextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: selectedDate != null
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color:
                            selectedDate != null ? textColorButton : textColor2,
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget phoneNumberInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "../assets/icon_call.svg",
                      width: 26,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: textButtonTextStyle.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      decoration: InputDecoration.collapsed(
                          hintText: "Phone Number",
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
                      style: textButtonTextStyle.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
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
                      style: textButtonTextStyle.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
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

    Widget confirmPasswordInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "../assets/icon_password_confirm.svg",
                      width: 26,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: TextFormField(
                      style: textButtonTextStyle.copyWith(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      decoration: InputDecoration.collapsed(
                          hintText: "Confirm Password",
                          hintStyle: textColor2TextStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    )),
                    SvgPicture.asset(
                      "../assets/icon_eye_close.svg",
                      width: 26,
                      height: 23,
                    ),
                    const SizedBox(
                      width: 2,
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
                        "Create Account",
                        style: textColor1TextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Improve your skills",
                    style: textColor1TextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "by trading skills for free!",
                    style: textColor1TextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    fullNameInput(),
                    userNameInput(),
                    const SizedBox(
                      height: 10,
                    ),
                    dateOfBirthInput(),
                    phoneNumberInput(),
                    emailAddressInput(),
                    passwordInput(),
                    confirmPasswordInput(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          alignment: Alignment.centerLeft,
                          child: Checkbox(
                            fillColor: MaterialStateProperty.all(checkBoxColor),
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            checkColor: backgroundColor,
                            activeColor: checkBoxColor,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 9),
                        Text(
                          "I agree with the",
                          style: textColor1TextStyle.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Terms of Service",
                          style: textColor3TextStyle.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "&",
                          style: textColor1TextStyle.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Privacy Policy",
                          style: textColor3TextStyle.copyWith(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      "Sign Up",
                      style: textButtonTextStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 64),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: textColor1TextStyle.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                " Login Now",
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
