import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/custom_widgets/custom_button.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:auto/ui/shared/my_images.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:auto/ui/views/login_screen/login_controller.dart';
import 'package:auto/ui/views/subscription_screen/subscription_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/data/repositories/read_all_models.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginController controller;
  final String baseUrl = "https://auto-sy.com/api";
  bool _isLoading = false;
  bool isLoggedIn = SharedPreferenceRepository().getIsLoggedIn();
  Future<void> login(String muid) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
      );
      return;
    }

    final url = Uri.parse('$baseUrl/login?muid=$muid');
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(url);
      print("response.statusCode ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String accessToken = data['access_token'];
        String tokenType = data['token_type'];
        int branchId = data['branch_id'];

        // Save to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setString('token_type', tokenType);
        List<String> mybranchIds = await prefs.getStringList('my_branchs_id') ?? [];
        mybranchIds.add(branchId.toString());
        await prefs.setStringList('my_branchs_id', mybranchIds);
        SharedPreferenceRepository().setIsLoggedIN(true);
        Get.to(() => const SubscriptionView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم الاشتراك بنجاح')),
        );
        print('Login successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل في تسجيل الدخول: ${response.statusCode}')),
        );
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تسجيل الدخول')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    controller = Get.put(LoginController());
    super.initState();
  }

  String? _validateCode(String? value) {
    if (value!.isEmpty) {
      return "هذا الحقل مطلوب";
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return "يرجى إدخال كود صالح (أرقام وحروف إنجليزية فقط)";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: CustomScrollView(
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
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    child: CustomText(
                      textType: TextStyleType.custom,
                      text: "الرجاء ادخال الكود الخاص بك لتحقيق تجربة مميزة",
                      textColor: AppColors.mainBlackColor,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsetsDirectional.only(top: 20, start: 10, end: 10, bottom: 20),
                    child: CustomTextField(
                      hintText: "الكود الخاص بك",
                      controller: controller.codeController,
                      contentPaddingLeft: screenWidth(10),
                      validator: _validateCode,
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : CustomButton(
                    text: "تأكيد",
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        login(controller.codeController.text);
                      }
                    },
                    widthButton: 3,
                    circularBorder: screenWidth(10),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  isLoggedIn? SizedBox():
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    child: CustomText(
                      textType: TextStyleType.custom,
                      text: "أو يمكنك المتابعة كزائر",
                      textColor: AppColors.mainBlackColor,
                    ),
                  ),
                  isLoggedIn? SizedBox():
                  TextButton(
                    onPressed: () async {
                      Get.to(() => const SubscriptionView());
                    },
                    child: const CustomText(
                      textType: TextStyleType.custom,
                      text: "المتابعة كزائر",
                      textColor: AppColors.blueB4,
                      textDecoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationColor: AppColors.blueB4,
                    ),
                  )
                ].animate(interval: 50.ms).scale(delay: 300.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
