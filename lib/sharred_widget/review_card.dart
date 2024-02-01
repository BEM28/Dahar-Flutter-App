import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.name,
    required this.comment,
    required this.date,
  });

  final String name, comment, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: RestoThemes.lightPink,
      ),
      child: Row(
        children: [
          Center(
            child: Image.asset(
              'assets/Image/reviewPerson.png',
              width: 48.w,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      name,
                      style: RestoThemes.heading1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  Text(date, style: RestoThemes.heading3),
                ],
              ),
              Text(comment, style: RestoThemes.heading3),
            ],
          ))
        ],
      ),
    );
  }
}
