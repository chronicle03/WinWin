import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    required String message,
    Color color = Colors.orangeAccent,
    IconData icon = Icons.warning,
  }) : super(
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 2.0,
                height: 48.0,
                color: Colors.white,
              ),
              const SizedBox(width: 16.0),
              Icon(
                icon,
                size: 28.0,
                color: Colors.white,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        );
}