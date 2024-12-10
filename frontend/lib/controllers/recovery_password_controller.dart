import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RecoveryPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo de e-mail é obrigatório';
    }

    if (!GetUtils.isEmail(value)) {
      return 'E-mail inválido';
    }

    return null;
  }


  Future<void> sendEmail() async {
    // Send email logic
    await Future.delayed(const Duration(seconds: 2));
  }  
}