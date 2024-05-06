import 'package:auto/core/utils/almohsen_string.dart';
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../shared/utils.dart';
import '../login_screen/login_view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight(2),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.blueB4,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Image.asset(
                    MyImages.logo,
                    color: AppColors.mainWhiteColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                  child: CustomText(
                    textType: TextStyleType.body,
                    text: AlmohsenString.wellcome_text ,
                    textColor: AppColors.mainBlackColor,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),


                TextButton(
                  onPressed: () {
                    // Navigate to the login screen
                    Get.offAll(() => const LoginView());
                  },
                  child: const CustomText(
                    fontSize: 30,
                    textType: TextStyleType.custom,
                    text:AlmohsenString.wellcome_Next,
                    textColor: AppColors.blueB4,
                    // textDecoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationColor: AppColors.blueB4,
                  ),
                )
              ].animate(interval: 50.ms).scale(delay: 300.ms),
            ),
          ),
        ],
      ),
    );
  }
}
