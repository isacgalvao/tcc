import 'package:flutter/material.dart';
import 'package:frontend/controllers/add_exam_controller.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AddExamPage extends StatelessWidget {
  AddExamPage({super.key});

  final controller = Get.put(AddExamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adicionar avaliação",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (controller.isLoading) {
              return Center(
                  child: SizedBox(
                width: 50,
                height: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: [
                    HexColor("#4E74F9"),
                  ],
                ),
              ));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      return ExamCard(controller.students[index]);
                    },
                  ),
                ),
                TeacherButton(
                  text: "Adicionar avaliação",
                  onPressed: controller.addExam,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
