import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CardRestoShimmer extends StatelessWidget {
  const CardRestoShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300.h,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            child: Shimmer.fromColors(
              baseColor: const Color(0xFFC8C8C8),
              highlightColor: const Color(0xFF909090),
              child: const Card(
                elevation: 0,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80.h,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 35.h,
                    child: Shimmer.fromColors(
                      baseColor: const Color(0xFF909090),
                      highlightColor: const Color(0xFFD1D0D0),
                      child: const Card(
                        elevation: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 30.h,
                    child: Shimmer.fromColors(
                      baseColor: const Color(0xFF909090),
                      highlightColor: const Color(0xFFD1D0D0),
                      child: const Card(
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            right: 20,
            child: SizedBox(
              width: 80.w,
              height: 50.h,
              child: Shimmer.fromColors(
                baseColor: const Color(0xFF909090),
                highlightColor: const Color(0xFFD1D0D0),
                child: const Card(
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
