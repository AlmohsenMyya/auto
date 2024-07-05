import 'package:auto/core/data/repositories/read_all_models.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/custom_widgets/custom_toast.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:auto/ui/views/notification_screen/notification_screen.dart';
import 'package:auto/ui/views/subjects_screen/subject_view.dart';
import 'package:auto/ui/views/subscription_screen/subscription_controller.dart';
import 'package:auto/ui/views/wellcom_screen/centers/centers_view.dart';
import 'package:auto/ui/views/wellcom_screen/contact_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../favorite_screen/favoriteQuestionsView.dart';
import '../wellcom_screen/about_view.dart';
import '../wellcom_screen/developers_view.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  late SubscriptionController controller;

  @override
  void initState() {
    controller = Get.put(SubscriptionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.exOnPrimaryContainer,
        appBar: MainAppBar(
          showArrowBack: false,
          onTap: () => Get.back(),
          titleTextStyle: TextStyle(
//
//
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 25,
              fontWeight: FontWeight.bold,
             // fontFamily: 'Alexandria'
     ),
          titleText: 'اتمتة',
          backGroundColor: context.exOnPrimaryContainer,
          // textStyle: const TextStyle(color: Colors.black)
        ),
        drawer: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 50),
          child: Drawer(
            width: screenWidth(1.5),
            backgroundColor: AppColors.mainBlackColor.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                      Get.to(NotificationScreen());
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: AppColors.mainWhiteColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          textType: TextStyleType.custom,
                          text: "الإشعارات",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                      Get.changeThemeMode(
                          Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: AppColors.mainWhiteColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          textType: TextStyleType.custom,
                          text: Get.isDarkMode ? "الوضع المظلم" : "وضع الضوء",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                      Get.to(AboutScreen());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.sell_outlined,
                          color: AppColors.mainWhiteColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        // CustomText(
                        //   textType: TextStyleType.custom,
                        //   text: "مراكز البيع",
                        // ),
                        InkWell(
                          borderRadius: BorderRadius.circular(screenWidth(10)),
                          splashColor: AppColors.blueB4,
                          onTap: () {
                            Get.to(CentersScreen());
                          },
                          child: Row(
                            children: [
                              // Image.asset(
                              //   "assets/images/icon_app.png",
                              //   height: 27,
                              // ),

                              CustomText(
                                textType: TextStyleType.custom,
                                text: " مراكز البيع ",
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                    Get.to(ContactScreen()); // توجيه إلى صفحة الأسئلة المفضلة
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.contact_phone_rounded,
                          color: AppColors.mainWhiteColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          textType: TextStyleType.custom,
                          text: "تواصل معنا ",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                      Get.to(FavoriteQuestionsView()); // توجيه إلى صفحة الأسئلة المفضلة
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: AppColors.mainWhiteColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          textType: TextStyleType.custom,
                          text: "الأسئلة المفضلة",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                      Get.to(AboutScreen());
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/icon_app.png",
                          height: 27,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          textType: TextStyleType.custom,
                          text: "حول التطبيق",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(screenWidth(10)),
                    splashColor: AppColors.blueB4,
                    onTap: () {
                      Get.to(DevelopersPage() );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.code,
                          color: AppColors.mainWhiteColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          textType: TextStyleType.custom,
                          text: "المطوريين",
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Container(
                  color: Colors.yellow,
                )
              : CustomScrollView(
                  slivers: [
                    // const SliverAppBar(
                    //   centerTitle: true,
                    //   pinned: true,
                    //   title: CustomText(
                    //     textType: TextStyleType.custom,
                    //     text: "Auto(اتمتة)",
                    //     textColor: AppColors.blueB4,
                    //   ),
                    // ),
                    SliverPadding(
                      padding: const EdgeInsetsDirectional.all(20),
                      sliver: SliverList.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 5),
                        itemCount: controller.branchs.length,
                        itemBuilder: (context, index2) {
                          return InkWell(
                            onTap: () async {
                              Get.to(() => SubjectView(
                                    branch_id: index2 + 1,
                                  ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: screenHeight(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.exSecondary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomText(
                                textType: TextStyleType.bodyBig,
                                text: controller.branchs[index2].name,
                              ),
                            ),
                          ).animate().scale(delay: 300.ms);
                        },
                      ),
                    ),
                  ],
                ),
        ));
  }
}
