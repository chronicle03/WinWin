import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';

class Username extends StatelessWidget {
  late TextEditingController usernameController = TextEditingController(text: '');
  Username(this.usernameController, {super.key});

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

  @override
  Widget build(BuildContext context) {
    return userNameInput();
  }
}