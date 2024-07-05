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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginController controller;
  final String baseUrl = "https://auto-sy.com/api";

  Future<void> login(String muid) async {
    final url = Uri.parse('$baseUrl/login?muid=$muid');

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
        await prefs.setInt('branch_id', branchId);
        Get.to(() => const SubscriptionView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم الاشتراك بنجاح')),
        );
        print('Login successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response.body}')),
        );
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  void initState() {
    controller = Get.put(LoginController());
    super.initState();
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
                      validator: (value) {
                        return value!.isEmpty ? "هذا الحقل مطلوب" : null;
                      },
                    ),
                  ),
                  CustomButton(
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
                  const Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    child: CustomText(
                      textType: TextStyleType.custom,
                      text:"أو يمكنك المتابعة كزائر",
                      textColor: AppColors.mainBlackColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
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
