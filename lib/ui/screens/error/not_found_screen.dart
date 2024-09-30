import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:award_ticket/index.dart';

class NotFoundScreen extends StatelessWidget {
  static String id = "not_found_screen";
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle kTitleTextStyle = GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 25.0.sp,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    );

    TextStyle kSubtitleTextStyle = GoogleFonts.poppins(
      color: Colors.black38,
      fontSize: 16.0.sp,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            Assets.images404Error,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 230.0.h,
            left: 30.0.w,
            child: Text(
              'Dead End',
              style: kTitleTextStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 170.0.h,
            left: 30.0.w,
            child: Text(
              'Oops! The page you are looking for\nis not found',
              style: kSubtitleTextStyle.copyWith(
                color: Colors.white54,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 30,
            right: 250.0,
            child: ReusablePrimaryButton(
              childText: StringResource.homeText,
              buttonColor: Colors.white,
              childTextColor: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
