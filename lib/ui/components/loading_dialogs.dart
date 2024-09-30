import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Center(
      child: Container(
        width: 80.0.w,
        height: 80.0.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(4.0.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0.w),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    ),
  );
}
