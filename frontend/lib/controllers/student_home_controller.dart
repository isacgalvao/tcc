import 'package:flutter/material.dart';
import 'package:frontend/clients/student_client.dart';
import 'package:get/get.dart';

class StudentHomeController extends GetxController {
  static const initialPage = 2;

  final _selectedIndex = initialPage.obs;
  final pageController = PageController(initialPage: initialPage);

  get selectedIndex => _selectedIndex.value;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}

class HomeController extends GetxController {
  final _isLoading = false.obs;
  final _avgGrade = 0.0.obs;
  final _absences = 0.obs;
  final _lowestGrade = 0.0.obs;
  final _highestGrade = 0.0.obs;

  get isLoading => _isLoading.value;
  get avgGrade => _avgGrade.value;
  get absences => _absences.value;
  get lowestGrade => _lowestGrade.value;
  get highestGrade => _highestGrade.value;

  final client = Get.put(StudentProfileClient());

  @override
  void onInit() {
    super.onInit();
    getStudentProfile();
  }

  void getStudentProfile() async {
    try {
      _isLoading(true);
      await client.getStudentMetrics();
      _avgGrade.value = 7.5;
      _absences.value = 12;
      _lowestGrade.value = 2.0;
      _highestGrade.value = 10.0;
    } finally {
      _isLoading(false);
    }
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  String getName() {
    return '{name}';
  }
}
