import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Observables
  final rememberObs = false.obs;

  bool get remember => rememberObs.value;

  void toggleRemember(dynamic value) {
    rememberObs.value = value;
  }

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo de e-mail é obrigatório';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo de senha é obrigatório';
    }
    return null;
  }
}
