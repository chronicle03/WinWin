import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';

class ConfirmPasswordInput extends StatelessWidget {
  late TextEditingController controller = TextEditingController(text: '');
  ConfirmPasswordInput(this.controller, {super.key});

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
                        controller: controller,
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
  @override
  Widget build(BuildContext context) {
    return confirmPasswordInput();
  }
}