import 'package:flutter/material.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';

class JobStatusInput extends StatelessWidget {
  late TextEditingController controller = TextEditingController(text: '');
  late UserModel loggedInUser;
  JobStatusInput(this.controller, this.loggedInUser, {super.key});

   Widget jobStatusInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Job Status",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
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
                    'assets/icon_bag.png',
                    width: 26,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextFormField(
                        controller: controller,
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: loggedInUser.jobStatus ??  "",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
              ),
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
    return jobStatusInput();
  }
}