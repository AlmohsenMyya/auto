import 'package:auto/core/data/repositories/back_up_repo.dart';
import 'package:auto/core/data/repositories/read_all_models.dart';
import 'package:auto/core/data/repositories/shared_preference_repository.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../core/data/network/api_client.dart';
import '../../../core/data/repositories/fav_not_repo.dart';
import '../../shared/custom_widgets/subscrib_new_subject_button.dart';
import '../back_up/back_up_bottom.dart';
import '../back_up/do_back_up.dart';
import '../courses_questions_screen/courses_questions_view.dart';
import '../explanation_screen/explanation_screen.dart';
import '../login_screen/login_view.dart';
import '../wellcom_screen/about_view.dart';
import '../wellcom_screen/developers_view.dart';

class SubscriptionView extends StatefulWidget {
  bool? isVistor;

  SubscriptionView({this.isVistor, super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  late SubscriptionController controller;
late ApiClient apiClient;
late FavoritesRepository favoritesRepository;
late BackupService backupService ;
  @override
  void initState() {

    apiClient = ApiClient(baseUrl: 'https://auto-sy.com/api');
    favoritesRepository = FavoritesRepository(apiClient: apiClient);
    backupService =BackupService(favoritesRepository: favoritesRepository);
    controller = Get.put(SubscriptionController());
    controller.readfile(widget.isVistor);
    JsonReader.fetchDataAndStore();
    super.initState();
  }

  Future<bool> _showExitConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('هل أنت متأكد أنك تريد الخروج من التطبيق؟',
                style: TextStyle(color: context.exPrimaryContainer)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('إلغاء',
                    style: TextStyle(color: context.exPrimaryContainer)),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // Close the app
                },
                child: Text('موافق',
                    style: TextStyle(color: context.exPrimaryContainer)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) async {
        await _showExitConfirmationDialog();
      },
      child: Scaffold(
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
            titleText: ' اتمتة',
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
                        ThemeMode themeMode =
                            SharedPreferenceRepository().getSavedThemeMode();
                        if (themeMode == ThemeMode.dark) {
                          themeMode = ThemeMode.light;
                        } else {
                          themeMode = ThemeMode.dark;
                        }
                        SharedPreferenceRepository().saveThemeMode(themeMode);
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
                        Get.to(CentersScreen());
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
                            borderRadius:
                                BorderRadius.circular(screenWidth(10)),
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
                        Get.to(
                            ContactScreen()); // توجيه إلى صفحة الأسئلة المفضلة
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
                        Get.to(
                            ExplanationPage()); // توجيه إلى صفحة الأسئلة المفضلة
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.mainWhiteColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomText(
                            textType: TextStyleType.custom,
                            text: " شرح التطبيق ",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // InkWell(
                    //   borderRadius: BorderRadius.circular(screenWidth(10)),
                    //   splashColor: AppColors.blueB4,
                    //   onTap: () {
                    //     Get.to(CoursesQuestionsView(
                    //       isFavorite: true,
                    //       id_course_bank_lesson_unite: -1,
                    //       coursName: "الأسئلة المفضلة",
                    //       subjectName: "",
                    //       type: "0",
                    //     )); // توجيه إلى صفحة الأسئلة المفضلة
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.favorite,
                    //         color: AppColors.mainWhiteColor,
                    //       ),
                    //       const SizedBox(
                    //         width: 20,
                    //       ),
                    //       CustomText(
                    //         textType: TextStyleType.custom,
                    //         text: "الأسئلة المفضلة",
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
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
                        Get.to(DevelopersPage());
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
                     SizedBox(
                      height:   SharedPreferenceRepository().getIsLoggedIn()
                          ?  20 :0,
                    ),
                    SharedPreferenceRepository().getIsLoggedIn()
                        ? BackupButton(
                      backupService: backupService, // تمرير الـ BackupService هنا
                    ):SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    SharedPreferenceRepository().getIsLoggedIn()
                        ? SubscriptionButton()
                        : InkWell(
                            borderRadius:
                                BorderRadius.circular(screenWidth(10)),
                            splashColor: AppColors.blueB4,
                            onTap: () {
                              Get.offAll(() => const LoginView());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.payment_rounded,
                                  color: AppColors.mainWhiteColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CustomText(
                                  textType: TextStyleType.custom,
                                  text: "الاشتراك بالتطبيق",
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          body: GetBuilder<SubscriptionController>(builder: (controller) {
            return controller.isLoading.value
                ? SpinKitThreeBounce(
                    color: AppColors.blueB4,
                    size: 50.0,
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
                            final branch = controller.branchs[index2];
                            final isVistor = branch.isVistor;
                            print(
                                "branch.isVistor ${branch.isVistor} ${branch.name}");
                            return InkWell(
                              onTap: () async {
                                // if (isVistor) {
                                JsonReader.fetchDataAndStore();
                                Get.to(() => SubjectView(
                                      branch: branch,
                                    ));
                                // }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: screenHeight(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: context.primaryColor,
                                      // لون مختلف للفروع المشتركة والزائرة
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: CustomText(
                                      textType: TextStyleType.bodyBig,
                                      text: branch.name,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !isVistor
                                            ? Colors.redAccent
                                            : Colors.green,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          if (!isVistor) {
                                          Get.to(LoginView());
                                          }
                                        },
                                        child: Text(
                                          !isVistor
                                              ? ' انقر للاشتراك '
                                              : 'تم الاشتراك ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().scale(delay: 300.ms);
                          },
                        ),
                      )
                    ],
                  );
          })
          //
          ),
    );
  }
}
