import 'package:flutter/material.dart';
import 'package:submisi_2/sharred_widget/anim_text.dart';

class NoConnectivity extends StatelessWidget {
  const NoConnectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AnimWithText(
          lottie: 'assets/Lottie/lost.json',
          text3:
              'No internet connection. Please check your network settings and try again.',
        ),
      ),
    );
  }
}
