import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final Color? foregroundColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final bool isCaps;
  final double? letterSpacing;
  final double? height;
  final double? width;
  final double? borderRadius;
  final void Function() onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.isCaps = false,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.foregroundColor,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 25.0.r),
        ),
        textStyle: GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),
      child: Container(
        height: height ?? 50.0.h,
        width: width ?? MediaQuery.of(context).size.width,
        padding: EdgeInsets.zero,
        child: Center(
          child: AutoSizeText(
            isCaps ? title.toUpperCase() : title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: textColor ?? Colors.white,
                  fontSize: textSize ?? 16.0.sp,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  letterSpacing: letterSpacing,
                ),
          ),
        ),
      ),
    );
  }
}
