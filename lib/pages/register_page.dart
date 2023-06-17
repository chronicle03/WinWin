import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/pages/constant.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController confirmPasswordController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController birthdateController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');

  String message = "null";
  bool isChecked = false;
  String? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    handleRegister(String message) {

      if (isChecked.toString() == "" || nameController.text == "" ||
          emailController.text == "" ||
          usernameController.text == "" ||
          phoneNumberController.text == "" ||
          selectedDate! == "" ||
          passwordController.text == "" ||
          confirmPasswordController.text == "" 
          ) {
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

      BlocProvider.of<UserBloc>(context).add(UserPostRegister(
          nameController.text,
          emailController.text,
          usernameController.text,
          phoneNumberController.text,
          selectedDate!,
          passwordController.text,
          confirmPasswordController.text,
          isChecked.toString()));

    }

    Widget header() {
      return Column(
        children: [
          const SizedBox(height: 13),
          Align(
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
        ],
      );
    }

    Widget fullNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon_profile_default.png",
                    width: 26,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: nameController,
                    style: textColor2TextStyle,
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
      );
    }

    Widget userNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                      'assets/icon_profile_add.png',
                      width: 26,
                    ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: usernameController,
                    style: textColor2TextStyle,
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
                Image.asset(
                  'assets/icon_calendar.png',
                  width: 26,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(selectedDate ?? 'Date of Birth',
                      style: textColor2TextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: textColor2,
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget phoneNumberInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                   Image.asset(
                      'assets/icon_call.png',
                      width: 26,
                    ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: phoneNumberController,
                    style: textColor2TextStyle,
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
      );
    }

    Widget emailAddressInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                      'assets/icon_email.png',
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
          )
        ],
      );
    }

    Widget passwordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                      'assets/icon_password.png',
                      width: 35,
                    ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: textColor2TextStyle,
                    decoration: InputDecoration.collapsed(
                        hintText: "Password",
                        hintStyle: textColor2TextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                  Image.asset(
                    "assets/icon_eye_close.png",
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
      );
    }

    Widget confirmPasswordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon_password_confirm.png",
                    width: 26,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                        obscureText: true,
                    controller: confirmPasswordController,
                    style: textColor2TextStyle,
                    decoration: InputDecoration.collapsed(
                        hintText: "Confirm Password",
                        hintStyle: textColor2TextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                  Image.asset(
                    "assets/icon_eye_close.png",
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
      );
    }

    Widget termsOfService() {
      return Row(
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
      );
    }

    Widget buttonSignUp(String message) {
      return Container(
        width: double.infinity,
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
            handleRegister(message);
          },
          child: Text(
            "Sign Up",
            style: textButtonTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    Widget loadingButton() {
      return Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Color(0xff30444F)),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Loading",
                style: textButtonTextStyle.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    Widget footer() {
      return Row(
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
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserRegisterError) {
            message = state.code;
          } else if (state is UserRegisterSuccess) {
            return Center(
              child: Text("Register Success"),
            );
          }

          return ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    header(),
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
                    const SizedBox(height: 12),
                    termsOfService(),
                    state is UserRegisterLoading
                        ? loadingButton()
                        : buttonSignUp(message),
                    footer(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
