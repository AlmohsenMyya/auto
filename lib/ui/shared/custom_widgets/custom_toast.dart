import 'package:auto/core/enums/message_type.dart';
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomToast {
  static showMessage({
    required String message,
    MessageType messageType = MessageType.info,
  }) {
    String imageName = "info";
    Color shadowColor = AppColors.mainBlueColor;

    switch (messageType) {
      case MessageType.info:
        imageName = 'info';
        shadowColor = AppColors.mainBlueColor;
        break;
      case MessageType.warning:
        imageName = 'warning';
        shadowColor = AppColors.mainOrangeColor;
        break;
      case MessageType.rejected:
        imageName = 'rejected-01';
        shadowColor = AppColors.mainRedColor;
        break;
      case MessageType.succsess:
        imageName = 'approved1-01';
        shadowColor = AppColors.mainColorGreen;
        break;
    }
    BotToast.showCustomText(
      duration: const Duration(seconds: 3),
      toastBuilder: (value) {
        return Container(
          width: screenWidth(1.5),
          height: screenWidth(2.8),
          decoration: BoxDecoration(
            color: AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "images/$imageName.svg",
                width: screenWidth(7),
                height: screenWidth(6),
              ),
              //(screenWidth(30)).ph,
              Text(
                message,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
