import 'package:flutter/material.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

class RegisterStudentController extends GetxController {
  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDateController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.onClose();
  }

  // Validators
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return GetUtils.isEmail(value) ? null : 'E-mail inválido';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return GetUtils.isPhoneNumber(value) ? null : 'Telefone inválido';
    }
    return null;
  }

  String? birthDateValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value) ? null : 'Data inválida';
    }
    return null;
  }

  // TODO: Implement registerStudent method
  Future<void> registerStudent() async {
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 2));
      successSnackbar('Sucesso', 'Aluno cadastrado com sucesso');
    }
  }
}