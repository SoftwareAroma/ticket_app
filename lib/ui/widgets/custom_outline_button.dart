import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlineButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  const CustomOutlineButton({
    super.key,
    this.title,
    this.onPressed,
    this.color,
    this.fontSize,
    this.letterSpacing,
    this.fontWeight,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color ?? Theme.of(context).colorScheme.primary,
        side: BorderSide(color: color ?? Theme.of(context).colorScheme.primary),
        textStyle: GoogleFonts.poppins(
          color: color ?? Theme.of(context).colorScheme.primary,
          letterSpacing: letterSpacing ?? 1.5,
          fontSize: fontSize ?? 16.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onPressed: onPressed ??
          () {
            Navigator.pop(context);
          },
      child: SizedBox(
        height: 40.0.h,
        child: Center(
          child: AutoSizeText(
            title ?? "CLOSE",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: fontSize ?? 16.0,
                  color: textColor ?? Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
      ),
    );
  }
}
