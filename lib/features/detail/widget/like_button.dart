import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class MyLikeButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isLiked;
  const MyLikeButton({super.key, this.onTap, this.isLiked = false});

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
            isLiked ? Icons.favorite : Icons.favorite_border_rounded,
            color: isLiked ? RestoThemes.lightPink : RestoThemes.black,
          )),
    );
  }
}
