import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFC8C8C8),
        highlightColor: const Color(0xFF909090),
        child: const Card(
          elevation: 0,
        ),
      ),
    );
  }
}
