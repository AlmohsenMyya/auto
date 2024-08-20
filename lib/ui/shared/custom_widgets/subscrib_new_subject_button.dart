import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/subscription_screen/subscription_view.dart';
import '../colors.dart';
import '../utils.dart';
import 'custom_text.dart';

class SubscriptionButton extends StatefulWidget {
  @override
  _SubscriptionButtonState createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends State<SubscriptionButton> {
  bool isSubscribing = true;

  @override
  void initState() {
    super.initState();
    _loadSubscriptionState();
  }

  // تحميل حالة الاشتراك من SharedPreferences
  void _loadSubscriptionState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSubscribing = prefs.getBool('isSubscribing') ?? true; // القيمة الافتراضية هي true
    });
  }

  // حفظ حالة الاشتراك في SharedPreferences
  void _toggleSubscriptionState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSubscribing = !isSubscribing;
      prefs.setBool('isSubscribing', isSubscribing);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(screenWidth(10)),
      splashColor: AppColors.blueB4,
      onTap: () {
        _toggleSubscriptionState();
        if (isSubscribing) {
          Get.offAll(() => SubscriptionView(
            isVistor: true,
          ));
        } else {
          Get.offAll(() => SubscriptionView());
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.local_fire_department,
            color: AppColors.mainColorGreen,
          ),
          const SizedBox(
            width: 20,
          ),
          CustomText(
            textType: TextStyleType.custom,
            text: isSubscribing ? "الاشتراك بمادة جديدة" : "العودة لاشتراكاتي",
          ),
        ],
      ),
    );
  }
}
