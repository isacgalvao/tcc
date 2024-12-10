import 'package:flutter/material.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

class StudentManagementController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Form key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDateController = TextEditingController();

  StudentManagementController(Student student) {
    nameController.text = student.name;
    // emailController.text = student.email;
    // phoneController.text = student.phone;
    // birthDateController.text = student.birthDate;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  Future<void> updateStudent() async {
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 2));
      successSnackbar('Sucesso', 'Aluno cadastrado com sucesso');
    }
  }

  Future<void> deleteStudent() async {
    try {
      _isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      successSnackbar('Sucesso', 'Aluno excluído com sucesso');
    } finally {
      _isLoading(false);
    }
  }

  Future<void> createAccess(String user) async {
    await Future.delayed(const Duration(seconds: 2));
    successSnackbar('Sucesso', 'Acesso criado com sucesso');
  }

  Future<void> revokeAccess() async {
    await Future.delayed(const Duration(seconds: 2));
    successSnackbar('Sucesso', 'Acesso revogado com sucesso');
  }
}