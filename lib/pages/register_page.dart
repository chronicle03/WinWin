import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/widgets/input/confirm_passwod.dart";
import "package:winwin/pages/widgets/input/email.dart";
import "package:winwin/pages/widgets/input/fullname.dart";
import "package:winwin/pages/widgets/input/password.dart";
import "package:winwin/pages/widgets/input/phone_number.dart";
import "package:winwin/pages/widgets/input/skill_select.dart";
import "package:winwin/pages/widgets/input/username.dart";
import "package:winwin/pages/widgets/loading_button.dart";
import "package:winwin/pages/widgets/snackbar.dart";

import "../bloc/skill_bloc.dart";
import "../data/models/user_model.dart";
import "../data/singleton/user_data.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController birthdateController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');

  String message = "null";
  bool isChecked = false;
  String? selectedDate;
  List<String> userSkill = [];
  UserModel? userModel = UserData.user;
  late SkillBloc _skillBloc;

  void _fetchSkills() {// Cek apakah data sudah diambil sebelumnya
    _skillBloc = BlocProvider.of<SkillBloc>(context);
    _skillBloc.add(GetSkillEvent());// Set variabel flag ke true setelah mengambil data
  }

  void updateUserSkills(List<String> skills) {
    setState(() {
      userSkill = skills;
    });
  }

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
      print("userSkill: $userSkill");
      BlocProvider.of<UserBloc>(context).add(UserPostRegister(
          nameController.text,
          emailController.text,
          usernameController.text,
          phoneNumberController.text,
          selectedDate!,
          passwordController.text,
          confirmPasswordController.text,
          isChecked.toString(),
          userSkill.toList()));
      setState(() {
        message = "null";
      });
      _fetchSkills();
      print(message);
      userSkill.clear();
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

    Widget buttonSignUp(String message, UserState state) {
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
            if (isChecked.toString() == "false" ||
                nameController.text == "" ||
                emailController.text == "" ||
                usernameController.text == "" ||
                phoneNumberController.text == "" ||
                selectedDate == "" ||
                passwordController.text == "" ||
                confirmPasswordController.text == "") {
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                color: Colors.orangeAccent,
                icon: Icons.warning,
                message: "Please fill in all the necessary information!",
              ));
            }else{
              handleRegister(message);
            }

            print(message);
          },
          child: Text(
            "Sign Up",
            style: textButtonTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
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
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              header(),
              const SizedBox(height: 10),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserPostError) {
                    message = state.code;
                    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
                      color: Colors.red,
                      icon: Icons.warning,
                      message: message,
                    ));
                  } else if (state is UserPostSuccess) {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushNamed(context, '/resend-verify-email');
                    });
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        FullNameInput(
                          controller: nameController,
                        ),
                        Username(usernameController),
                        const SizedBox(
                          height: 10,
                        ),
                        dateOfBirthInput(),
                        PhoneNumberInput(controller: phoneNumberController),
                        SkillSelect(
                            userSkill, updateUserSkills),
                        EmailInput(controller: emailController),
                        PasswordInput(controller: passwordController),
                        ConfirmPasswordInput(confirmPasswordController),
                        // SkillSelect(),
                        const SizedBox(height: 12),
                        termsOfService(),
                        state is UserPostLoading
                            ? LoadingButton()
                            : buttonSignUp(message, state),
                        footer(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
