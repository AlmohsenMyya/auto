import 'package:auto/core/services/base_controller.dart';
import 'package:flutter/material.dart';

class LoginController extends BaseController {
  TextEditingController codeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
