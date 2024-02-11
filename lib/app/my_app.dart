import 'package:auto/core/enums/connectivity_status.dart';
import 'package:auto/core/translation/app_translation.dart';
import 'package:auto/core/utils/general_util.dart';
import 'package:auto/ui/views/splash_screen/splash_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //mmmm
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) =>
          connectivityService.connectivityStatusController.stream,
      initialData: ConnectivityStatus.onLine,
      child: GetMaterialApp(
          theme: ThemeData(fontFamily: 'Alexandria'),
          defaultTransition: GetPlatform.isAndroid
              ? Transition.rightToLeftWithFade
              : Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 400),
          translations: AppTranlation(),
          locale: getLocal(),
          fallbackLocale: getLocal(),
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //       // backgroundColor: Colors.transparent,
          //       ),
          // ),
          title: 'Auto',
          home:
              //storage.getTokenInfo() != null
              ///?
              const SplashView()
          //: const SignInView()
          ),
    );
  }
}

Locale getLocal() {
  if (storage.getAppLanguage() == 'ar') {
    return const Locale('ar', 'SA');
  } else {
    return const Locale('en', 'US');
  }
}
