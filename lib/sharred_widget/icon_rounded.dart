import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class IconRound extends StatelessWidget {
  IconData? icons;
  void Function()? onTap;
  IconRound({
    super.key,
    this.icons,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 35.w,
        height: 35.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: RestoThemes.orange,
          boxShadow: RestoThemes.iconShadow(),
        ),
        child: Icon(
          icons,
          color: RestoThemes.black,
        ),
      ),
    );
  }
}
