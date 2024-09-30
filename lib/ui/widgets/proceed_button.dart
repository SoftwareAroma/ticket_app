import 'package:flutter/material.dart';
import 'package:award_ticket/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProceedButton extends StatelessWidget {
  final void Function() onPressed;
  final String? text;
  final double? textSize;
  final Color? buttonColor;
  final Color? textColor;

  const ProceedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.textSize,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0.w,
          vertical: 5.0.h,
        ),
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).colorScheme.primary,
        ),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(50.0.r),
          color: buttonColor ?? Theme.of(context).colorScheme.primary,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0.w,
              vertical: 5.0.h,
            ),
            child: Center(
              child: CustomText(
                text ?? "Proceed",
                fontSize: textSize ?? 28.0,
                color: textColor ?? Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
