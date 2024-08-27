import 'package:flutter/material.dart';

import '../../../core/data/repositories/back_up_repo.dart';

class BackupRestoreButton extends StatelessWidget {
  final BackupService backupService;

  BackupRestoreButton({required this.backupService});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // عرض مربع حوار انتظار
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('استعادة النسخة الاحتياطية'),
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Expanded(child: Text('يرجى الانتظار... عملية الاستعادة قيد التنفيذ')),
                ],
              ),
            );
          },
        );

        try {
          // استدعاء عملية استعادة النسخة الاحتياطية
          await backupService.fetchAndSaveBackup();

          // إغلاق مربع الحوار بعد النجاح
          Navigator.of(context).pop();

          // عرض رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم استعادة النسخة الاحتياطية بنجاح!')),
          );
        } catch (e) {
          // إغلاق مربع الحوار في حالة الفشل
          Navigator.of(context).pop();

          // عرض رسالة خطأ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشلت عملية استعادة النسخة الاحتياطية: ')),
          );
        }
      },
      child: Text('استعادة النسخة الاحتياطية'),
    );
  }
}
