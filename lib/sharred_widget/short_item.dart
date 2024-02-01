import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class ShortItem extends StatelessWidget {
  final String title;
  void Function()? onTap;
  ShortItem({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: RestoThemes.lightPink,
            borderRadius: BorderRadius.circular(20.r)),
        child: Center(
          child: Text(
            title,
            style: RestoThemes.heading1,
          ),
        ),
      ),
    );
  }
}
