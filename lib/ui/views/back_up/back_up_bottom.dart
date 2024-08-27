import 'package:auto/ui/views/back_up/restore_back_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/repositories/back_up_repo.dart';
import 'do_back_up.dart';

class BackupButton extends StatelessWidget {
  final BackupService backupService;

  BackupButton({required this.backupService});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.blueAccent,
      onTap: () async {

        SharedPreferences prefs = await SharedPreferences.getInstance();
       String? muid = await prefs.getString('muid');
        _showBackupDialog(context , muid);
      },
      child: Row(
        children: [
          Icon(
            Icons.backup,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          Text(
            "النسخ الاحتياطي",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog(BuildContext context, String? muid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("النسخ الاحتياطي"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                if (muid != null) ...[
                  Text(
                    "كود التفعيل (MUID) هو الكود الذي يمكنك من استعادة بياناتك في حال قمت بتبديل جهازك أو إعادة تثبيت التطبيق. "
                        "يرجى التأكد من نسخ هذا الكود والاحتفاظ به في مكان آمن، حيث أنك ستحتاج إليه لاستعادة بياناتك في المستقبل.",
                    // style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 20),
                  Text(
                    "كود التفعيل الخاص بك:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SelectableText(
                    muid,
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: muid));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم نسخ كود التفعيل إلى الحافظة")),
                      );
                    },
                    icon: Icon(Icons.copy),
                    label: Text("نسخ كود التفعيل"),
                  ),
                ],
                SizedBox(height: 20),
                Text("يمكنك إجراء نسخ احتياطي أو استعادة النسخة الاحتياطية الخاصة بك. اختر الإجراء المطلوب:"),
                SizedBox(height: 20),
                DoBackupButton(
                  backupService: backupService, // تمرير الـ BackupService هنا
                ),
                SizedBox(height: 10),
                BackupRestoreButton(
                  backupService: backupService, // تمرير الـ BackupService هنا
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق الحوار
                  },
                  child: Text("إغلاق"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
