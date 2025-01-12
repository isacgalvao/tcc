import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassResumeController extends GetxController {
  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;

  final pageController = PageController();

  void onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
