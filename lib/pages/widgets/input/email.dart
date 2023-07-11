import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';

class EmailInput extends StatelessWidget {
  late TextEditingController controller = TextEditingController(text: '');
  late String hintText;
  late bool enable;
   EmailInput({TextEditingController? controller, String? hintText, bool? enable}) {
    this.controller = controller ?? TextEditingController(text: '');
    this.hintText = hintText ?? 'Email Address';
    this.enable = enable ?? true;
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
                color: enable ? appBarColor : Colors.white60, borderRadius: BorderRadius.circular(10.0)),
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
                        enabled: enable ? true : false,
                        controller: controller,
                        style: textColor2TextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: hintText,
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
    return emailAddressInput();
  }
}