import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/custom_widgets/custom_button.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

double screenWidth(double perecent) {
  return Get.size.width / perecent;
}

double screenHeight(double perecent) {
  return Get.size.height / perecent;
}

void customLoader() => BotToast.showCustomLoading(toastBuilder: (builder) {
      return Container(
        width: screenWidth(5),
        height: screenWidth(5),
        decoration: BoxDecoration(
            color: AppColors.mainBlackColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15)),
        child: const SpinKitCircle(color: AppColors.mainYellowColor),
      );
    });

Widget customFaildConnection({required VoidCallback onPressed}) => Column(
      children: [
        const CustomText(
          text: "",
          textType: TextStyleType.custom,
          textColor: AppColors.mainBlackColor,
        ),
        //screenHeight(20).ph,
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: screenWidth(3)),
          child: CustomButton(
            onPressed: onPressed,
            text: "",
            circularBorder: screenWidth(10),
            widthButton: 3,
            heightButton: 10,
            backgroundColor: AppColors.mainYellowColor,
          ),
        )
      ],
    );
double get taxAmount => 0.18;
double get deliveryAmount => 0.1;
