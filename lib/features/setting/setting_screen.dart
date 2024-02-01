import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:submisi_2/constant/resto_themes.dart';
import 'package:submisi_2/services/provider/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: RestoThemes.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings', style: RestoThemes.heading1),
              SizedBox(height: 8.h),
              ChangeNotifierProvider(
                create: (context) => SchedulingProvider()..loadScheduling(),
                child: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                  return Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: RestoThemes.lightPink),
                    child: Row(
                      children: [
                        Text('Notification', style: RestoThemes.heading1),
                        const Spacer(),
                        Switch.adaptive(
                            value: scheduled.isScheduled,
                            activeColor: RestoThemes.orange,
                            onChanged: (value) async {
                              if (Platform.isIOS) {
                                _customModal(context);
                              } else {
                                scheduled.scheduledRestaurants(value);
                              }
                            }),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_customModal(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
