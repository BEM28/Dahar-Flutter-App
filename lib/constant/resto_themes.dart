import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RestoThemes {
  //Colors
  static const Color backgroundColor = Color(0xFFF9F4F1);
  static const Color orange = Color(0xFFFF9040);
  static const Color lightOrange = Color(0xFFFCBA8A);
  static const Color lightPink = Color(0xFFF5E8E0);
  static const Color blueBlack = Color(0xFF19191A);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF424242);
  static const Color lightGrey = Color(0xFFF9F4F1);
  static const Color black = Color(0xFF111111);

  static List<Color> selectedColor = [
    RestoThemes.lightOrange,
    RestoThemes.lightPink,
    RestoThemes.white,
  ];
  static List<Color> unSelectedColor = [
    RestoThemes.white,
    RestoThemes.white,
  ];

  //Text Style
  static TextStyle title = TextStyle(
    fontFamily: GoogleFonts.satisfy().fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.blueBlack,
  );
  static TextStyle showMore = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.orange,
  );
  static TextStyle heading1 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.blueBlack,
  );
  static TextStyle heading1White = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.white,
  );
  static TextStyle hintStyle = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.grey,
  );
  static TextStyle heading2 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.grey,
  );
  static TextStyle heading3 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.blueBlack,
  );
  static TextStyle heading4 = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: RestoThemes.orange,
  );

  //shadow
  static List<BoxShadow> restoShadow() {
    return [
      BoxShadow(
        color: RestoThemes.black.withOpacity(0.2),
        offset: const Offset(0, 4),
        blurRadius: 20,
        spreadRadius: 4,
      ),
    ];
  }

  static List<BoxShadow> iconShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Warna bayangan
        spreadRadius: 1, // Menyebar dari bayangan
        blurRadius: 3, // Tingkat keburaman bayangan
        offset: const Offset(0, 3), // Posisi bayangan (x, y)
      ),
    ];
  }
}
