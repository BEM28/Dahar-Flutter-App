import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class MyFloatting extends StatelessWidget {
  MyFloatting({
    super.key,
    this.onTap,
  });
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.w,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: RestoThemes.orange,
          boxShadow: RestoThemes.iconShadow(),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.r),
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
        ),
        child: Image.asset('assets/Image/chat.png'),
      ),
    );
  }
}
