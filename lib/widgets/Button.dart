import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  Button({
    this.buttonTitle = "",
    this.onTap,
    this.buttonColor,
    this.textColor
  });

  final String buttonTitle;

  final dynamic onTap;

  final Color? buttonColor;

  final Color? textColor;

  final borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 42,
        child: Material(
          elevation: 2,
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: Text(buttonTitle, style: TextStyle(
                  fontSize: 18,
                  color: textColor == null ? Colors.white : textColor,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
