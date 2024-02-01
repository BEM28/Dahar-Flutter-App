import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class BarModal extends StatelessWidget {
  final String title;
  final String active;
  final void Function()? onTap;
  BarModal({
    super.key,
    required this.title,
    required this.active,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: active == title
              ? RestoThemes.orange
              : RestoThemes.backgroundColor,
        ),
        child: Center(
          child: Text(
            title,
            style:
                active == title ? RestoThemes.heading3 : RestoThemes.heading4,
          ),
        ),
      ),
    );
  }
}
