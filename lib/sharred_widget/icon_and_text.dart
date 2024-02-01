import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class IconAndText extends StatelessWidget {
  final IconData? icon;
  final String? text;
  void Function()? onTap;
  IconAndText({
    super.key,
    this.icon,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: RestoThemes.iconShadow(),
          borderRadius: BorderRadius.circular(20.r),
          color: RestoThemes.orange,
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 3.w),
            Text(text!, style: RestoThemes.heading1),
          ],
        ),
      ),
    );
  }
}
