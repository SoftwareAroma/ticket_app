import 'package:flutter/material.dart';

class BrandDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  const BrandDivider({
    super.key,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color,
      thickness: 1.0,
    );
  }
}
