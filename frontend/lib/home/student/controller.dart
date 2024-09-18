import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  final selectedIndex = 0.obs;
  final pageController = PageController();

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class PerfilController extends GetxController {
  final passwordController = TextEditingController();

  final obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
