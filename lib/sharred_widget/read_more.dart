import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(text,
        trimLines: 2,
        style: RestoThemes.heading3,
        lessStyle: RestoThemes.showMore,
        colorClickableText: RestoThemes.orange,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: RestoThemes.showMore);
  }
}
