import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:auto/ui/views/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/Background icons.svg',
              fit: BoxFit.cover,
            ),
            Center(
              child: SvgPicture.asset('assets/images/Logo.svg'),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: screenWidth(1)),
              child: const SpinKitThreeBounce(
                color: AppColors.mainOrangeColor,
                size: 50.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
