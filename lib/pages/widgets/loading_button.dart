import "package:flutter/material.dart";
import "../constant.dart";

class LoadingButton extends StatelessWidget {
  double width = double.infinity;

  LoadingButton({super.key, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
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
}