import "package:flutter/material.dart";

import "../../data/models/user_model.dart";
import "../constant.dart";

class AvatarCustom extends StatefulWidget {
  UserModel user;
  double width;
  double height;
  Color color;
  double fontSize;
  AvatarCustom ({super.key, required this.user, required this.width, required this.height, required this.color, required this.fontSize});

  @override
  State<AvatarCustom> createState() => AvatarCustom_State();
}

class AvatarCustom_State extends State<AvatarCustom> {
  @override
  Widget build(BuildContext context) {

    String getInitials(String fullName) {
      List<String> words = fullName.split(" ");
      String initials = "";

      for (int i = 0; i < words.length && i < 2; i++) {
        String word = words[i];
        if (word.isNotEmpty) {
          initials += word[0].toUpperCase();
        }
      }

      return initials.toUpperCase();
    }

    return ClipOval(
      child: Container(
          width: widget.width,
          height: widget.height,
          color: widget.color,
          child: Center(
              child: Text(getInitials(widget.user.name!), style: TextStyle(color: Colors.blue, fontSize: widget.fontSize),))),
    );
  }
}
