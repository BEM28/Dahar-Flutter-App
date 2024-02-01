import 'dart:async';
import 'package:flutter/material.dart';
import 'package:submisi_2/sharred_widget/anim_text.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/features/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5), // Ganti durasi sesuai kebutuhan Anda
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: RestoThemes.orange,
        body: AnimWithText(
          lottie: 'assets/Lottie/lightorangeAnim.json',
          text1: 'Dahar',
          text2: 'Find Place To Eat',
        ));
  }
}
