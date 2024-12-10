import 'package:flutter/material.dart';
import 'package:frontend/controllers/add_attendance_controller.dart';
import 'package:frontend/pages/qr_code_attendance_page.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAttendancePage extends StatelessWidget {
  AddAttendancePage({super.key});

  final controller = Get.put(AddAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Presença',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(
                Icons.qr_code_2,
                size: 32,
              ),
              onPressed: () => Get.to(() => QRCodeAttendancePage()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data selecionada:',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: HexColor("#6F6F79"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      controller.selectedDate = await showDatePicker(
                        context: context,
                        initialDate: controller.selectedDate,
                        firstDate: controller.firstDate,
                        lastDate: controller.lastDate,
                        locale: const Locale('pt', 'BR'),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: HexColor("#E8F2FF"),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: HexColor("#0C448C"),
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          controller.isToday()
                              ? 'Hoje'
                              : controller.formattedDate,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#0C448C"),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                indent: 32,
                endIndent: 32,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return AttendanceCard(
                      student: controller.students[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TeacherButton(
                text: 'Lançar presença',
                onPressed: controller.saveAttendance,
              )
            ],
          ),
        ),
      ),
    );
  }
}
