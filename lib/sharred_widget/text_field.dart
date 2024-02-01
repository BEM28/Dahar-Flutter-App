import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:submisi_2/constant/resto_themes.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  const MyTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: RestoThemes.lightPink,
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        style: RestoThemes.heading2,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: RestoThemes.hintStyle,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: RestoThemes.orange),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: RestoThemes.grey),
          ),
        ),
      ),
    );
  }
}
