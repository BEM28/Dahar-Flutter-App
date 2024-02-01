import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: RestoThemes.lightPink,
        boxShadow: RestoThemes.iconShadow(),
      ),
      child: Row(
        children: [
          Center(
              child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: RestoThemes.orange,
              boxShadow: RestoThemes.iconShadow(),
            ),
            child: Icon(
              Icons.fastfood_sharp,
              size: 30.sp,
            ),
          )),
          SizedBox(width: 10.w),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: RestoThemes.heading1),
            ],
          ))
        ],
      ),
    );
  }
}
