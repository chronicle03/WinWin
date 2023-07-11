import 'package:flutter/material.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';

class BioInput extends StatelessWidget {
    late TextEditingController controller = TextEditingController(text: '');
  late UserModel loggedInUser;
  BioInput(this.controller, this.loggedInUser, {super.key});

   Widget bioInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Bio",
            style: textColor3TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 151,
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
            decoration: BoxDecoration(
              color: appBarColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icon_profile_free.png',
                      width: 26,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        textAlign: TextAlign.justify,
                        style: textButtonTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 6,
                        decoration: InputDecoration.collapsed(
                          hintText:
                              loggedInUser.bio ??  "",
                          hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

  @override
  Widget build(BuildContext context) {
    return bioInput();
  }
}