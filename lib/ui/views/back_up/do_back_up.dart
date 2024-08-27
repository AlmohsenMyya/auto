import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../../../core/data/repositories/back_up_repo.dart';

class DoBackupButton extends StatefulWidget {
  final BackupService backupService;

  const DoBackupButton({Key? key, required this.backupService}) : super(key: key);

  @override
  _DoBackupButtonState createState() => _DoBackupButtonState();
}

class _DoBackupButtonState extends State<DoBackupButton> {
  bool _isLoading = false;

  Future<void> _backupData() async {
    // التحقق من الاتصال بالإنترنت
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // إظهار مربع حواري أثناء عملية النسخ الاحتياطي
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  'يرجى الانتظار، النسخة الاحتياطية قد تحتاج لبعض الوقت...',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );

    try {
      await widget.backupService.backupFavoritesAndNotes();
      Navigator.of(context).pop(); // إغلاق مربع الحوار
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حفظ النسخة الاحتياطية بنجاح')),
      );
    } catch (e) {
      Navigator.of(context).pop(); // إغلاق مربع الحوار
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء حفظ النسخة الاحتياطية: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _backupData,
      child: _isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text('حفظ نسخة احتياطية'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
