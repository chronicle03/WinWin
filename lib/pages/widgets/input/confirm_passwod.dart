import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';

class ConfirmPasswordInput extends StatefulWidget {
  late TextEditingController controller = TextEditingController(text: '');
  ConfirmPasswordInput(this.controller, {super.key});

  @override
  State<ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<ConfirmPasswordInput> {
  bool isTapEye = true;

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
                        obscureText: isTapEye ?? true,
                        controller: widget.controller,
                        style: textColor2TextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: "Confirm Password",
                            hintStyle: textColor2TextStyle.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500)),
                      )),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isTapEye == false){
                          isTapEye = true;
                        }else{
                          isTapEye = false;
                        }
                      });
                    },
                    icon: Image.asset(
                      'assets/icon_eye_close.png',
                      width: 26,
                      height: 23,
                    ),
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