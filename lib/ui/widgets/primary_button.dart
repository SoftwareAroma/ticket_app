import 'package:flutter/material.dart';

class ReusablePrimaryButton extends StatelessWidget {
  final String childText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color childTextColor;
  const ReusablePrimaryButton({
    super.key,
    required this.childText,
    required this.onPressed,
    required this.buttonColor,
    required this.childTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40.0,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: buttonColor,
        ),
        child: Center(
            child: Text(
          childText.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            color: childTextColor,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }
}
