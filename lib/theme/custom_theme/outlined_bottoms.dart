import 'package:flutter/material.dart';

class TOutlinedButton{
  TOutlinedButton._();
  static final lightOutButtomThem =OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0.0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
      textStyle: const TextStyle(fontWeight:FontWeight.w600,color: Colors.black,fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    )
  );
  static final darkOutButtomThem =OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0.0,
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.blue),
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
        textStyle: const TextStyle(fontWeight:FontWeight.w600,color: Colors.white,fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      )
  );
}