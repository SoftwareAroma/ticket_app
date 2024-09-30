import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

Future<dynamic> showCustomFlushBar({
  required context,
  required String message,
  String? title,
  Color? backgroundColor,
  Color? titleColor,
  Color? iconColor,
  Color? messageColor,
  double? iconSize,
  double? messageSize,
  TextAlign? messageAlignment,
  double? titleSize,
  IconData? icon,
  Widget? titleText,
  Duration? duration,
  bool shouldIconPulse = true,
  double borderWidth = 1.0,
  Color? borderColor,
  BorderRadius? borderRadius,
  EdgeInsets padding = const EdgeInsets.all(16.0),
  EdgeInsets margin = const EdgeInsets.all(0.0),
  FlushbarPosition? position,
}) {
  return Flushbar(
    title: title,
    message: message,
    flushbarPosition: position ?? FlushbarPosition.BOTTOM,
    titleSize: titleSize ?? 18.0,
    titleColor: titleColor ?? Theme.of(context).colorScheme.onPrimary,
    backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
    messageColor: messageColor ?? Theme.of(context).colorScheme.onPrimary,
    shouldIconPulse: shouldIconPulse,
    borderWidth: borderWidth,
    borderColor: borderColor,
    borderRadius: borderRadius,
    margin: margin,
    padding: padding,
    icon: Icon(
      icon ?? LineAwesomeIcons.exclamation_circle_solid,
      color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
      size: iconSize,
    ),
    duration: duration ?? const Duration(seconds: 5),
  ).show(context);
}
