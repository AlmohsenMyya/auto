import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/my_images.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:auto/ui/views/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.mainGrey2Color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(MyImages.logo),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: screenWidth(10)),
            child: const SpinKitThreeBounce(
              color: AppColors.blueB4,
              size: 50.0,
            ),
          ),
        ].animate(interval: 50.ms).scale(delay: 300.ms),
      ),
    );
  }
}
