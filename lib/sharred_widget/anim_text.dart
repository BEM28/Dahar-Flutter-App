import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class AnimWithText extends StatelessWidget {
  final String lottie;
  final String? text1;
  final String? text2;
  final String? text3;
  const AnimWithText({
    super.key,
    required this.lottie,
    this.text1,
    this.text2,
    this.text3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 500.h,
      width: double.infinity,
      child: Column(
        children: [
          Lottie.asset(lottie),
          Text(
            text1 ?? "",
            textAlign: TextAlign.center,
            style: RestoThemes.title,
          ),
          Text(
            text2 ?? "",
            textAlign: TextAlign.center,
            style: RestoThemes.heading1,
          ),
          Text(
            text3 ?? "",
            textAlign: TextAlign.center,
            style: RestoThemes.heading3,
          ),
        ],
      ),
    ));
  }
}
