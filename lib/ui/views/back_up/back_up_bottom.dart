import 'package:auto/ui/views/back_up/restore_back_up.dart';
import 'package:flutter/material.dart';

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
      onTap: () {
        _showBackupDialog(context);
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

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("النسخ الاحتياطي"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
        );
      },
    );
  }}
