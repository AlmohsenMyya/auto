import 'package:auto/config/theme/app_theme.dart';
import 'package:auto/core/enums/connectivity_status.dart';
import 'package:auto/core/translation/app_translation.dart';
import 'package:auto/core/utils/general_util.dart';
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/views/splash_screen/splash_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../core/data/repositories/shared_preference_repository.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme:  AppBarTheme(titleTextStyle:TextStyle(  color:const ColorScheme.light().primary) ),
  useMaterial3: true,
  // fontFamily: 'Alexandria',
primaryIconTheme: const IconThemeData( color: Colors.black),
  iconTheme: const  IconThemeData(color: Colors.black),
  brightness: Brightness.light,
  primaryColor: AppColors.mainWhiteColor,
  colorScheme: const ColorScheme(

    brightness: Brightness.light,
    primary:  Color(0xFF48b4e0),
    onPrimary: Colors.white,
    secondary: Colors.green,
    onSecondary: Colors.black,
    primaryContainer: Colors.white,
    error: Colors.black,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.red,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);
ThemeData darkTheme = ThemeData(
  appBarTheme:   AppBarTheme(titleTextStyle:TextStyle( // fontFamily: 'Alexandria',
 color:const ColorScheme.dark().primary) ),
  useMaterial3: true,
  primaryColor: AppColors.mainGrey2Color,
  primaryColorDark: AppColors.mainGrey2Color,
  brightness: Brightness.dark,
  // fontFamily: 'Alexandria',
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary:  Colors.white,
    onPrimary: Colors.white,
    secondary: Colors.green,
    onSecondary: Colors.black,
    primaryContainer: Colors.white,
    error: Colors.black,
    onError: Colors.white,
    background: Color(0xFF262626),
    onBackground: Colors.red,
    surface: Colors.grey,
    onSurface: Colors.white,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //mmmm
  @override
  Widget build(BuildContext context) {



    return ScreenUtilInit(

      designSize: const Size(375, 812),
      builder:(context, child) =>StreamProvider(
        create: (context) => connectivityService.connectivityStatusController.stream,
        initialData: ConnectivityStatus.onLine,
        child: GetMaterialApp(
            theme: AppTheme.light,
            themeMode: SharedPreferenceRepository().getSavedThemeMode(),
            darkTheme: AppTheme.dark,

            defaultTransition:
            GetPlatform.isAndroid ? Transition.rightToLeftWithFade : Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 400),
            translations: AppTranlation(),
            locale: getLocal(),
            fallbackLocale: getLocal(),
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,

            title: 'Auto',
            home:const SplashView()
        ),
      ),);
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar') {
    return const Locale('ar', 'SA');
  } else {
    return const Locale('en', 'US');
  }
}
