import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/login_screen/login_view.dart';// تأكد من استبدال your_app باسم حزمة تطبيقك

class SubscriptionDialog {
  static void showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'لا يمكن الدخول',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: context.exPrimaryContainer,
            ),
          ),
          content: Text(
            'يتطلب الدخول الاشتراك. يرجى الاشتراك للاستمرار.',
            style: TextStyle(color: context.exPrimaryContainer),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'اشتراك',
                style: TextStyle(color: context.exPrimaryContainer),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
            ),
          ],
        );
      },
    );
  }
  /// تحقق مما إذا كان `branchId` موجودًا في قائمة `myBranchIds`.
  static Future<bool> isMyBranch(String branchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? myBranchIds = prefs.getStringList('my_branchs_id');

    // إذا كانت القائمة غير فارغة، تحقق من وجود branchId فيها.
    if (myBranchIds != null && myBranchIds.isNotEmpty) {
      return myBranchIds.contains(branchId);
    }

    // إذا كانت القائمة فارغة أو غير موجودة، أرجع false.
    return false;
  }
}
