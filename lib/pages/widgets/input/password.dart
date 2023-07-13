import 'package:flutter/material.dart';
import 'package:winwin/pages/constant.dart';

class PasswordInput extends StatefulWidget {
  late TextEditingController controller = TextEditingController(text: '');
  late String hintText;
  late bool enable;
   PasswordInput({TextEditingController? controller, String? hintText, bool? enable}) {
    this.controller = controller ?? TextEditingController(text: '');
    this.hintText = hintText ?? 'Password';
    this.enable = enable ?? true;
  }

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isTapEye = true;

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
                color: widget.enable ? appBarColor : Colors.white60, borderRadius: BorderRadius.circular(10.0)),
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
                        enabled: widget.enable? true : false,
                        controller: widget.controller,
                        obscureText: isTapEye ?? false,
                        style: textColor2TextStyle,
                        decoration: InputDecoration.collapsed(
                            hintText: widget.hintText,
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
                    width: 9,
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
    return passwordInput();
  }
}