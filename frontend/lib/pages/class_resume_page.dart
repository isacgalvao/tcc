import 'package:flutter/material.dart';
import 'package:frontend/controllers/class_resume_controller.dart';
import 'package:frontend/models/class.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ClassResumePage extends StatelessWidget {
  final Class _class;

  ClassResumePage(this._class, {super.key});

  final controller = Get.put(ClassResumeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${_class.name} - ${_class.subject}",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: PageView(
        children: [],
      ),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.assessment_outlined),
              title: Text(
                "Notas",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              title: Text(
                "Frequência",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
