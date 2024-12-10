import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/class_management_controller.dart';
import 'package:frontend/models/attendance.dart';
import 'package:frontend/models/class.dart';
import 'package:frontend/models/exam.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/pages/add_attendance_page.dart';
import 'package:frontend/pages/add_exam_page.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ClassManagementPage extends StatelessWidget {
  final Class _class;

  ClassManagementPage(this._class, {super.key}) {
    controller = Get.put(ClassManagementController(_class));
  }

  late final ClassManagementController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _class.name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AttendancePage(),
              NotesPage(),
              ExamsPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SalomonBottomBar(
            currentIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
            selectedItemColor: HexColor("#4E74F9"),
            items: [
              _buildBarItem(
                title: "Presença",
                asset: "assets/icons/class_management/attendance.svg",
              ),
              _buildBarItem(
                title: "Anotações",
                asset: "assets/icons/class_management/notes.svg",
                width: 20,
                height: 16,
              ),
              _buildBarItem(
                title: "Avaliação",
                asset: "assets/icons/class_management/exams.svg",
              ),
              _buildBarItem(
                title: "Config.",
                asset: "assets/icons/class_management/settings.svg",
              )
            ],
          ),
        ),
      ),
    );
  }

  SalomonBottomBarItem _buildBarItem({
    required String title,
    required String asset,
    double width = 24,
    double height = 24,
  }) {
    return SalomonBottomBarItem(
      activeIcon: SvgPicture.asset(
        asset,
        width: width,
        height: height,
        colorFilter: ColorFilter.mode(
          HexColor("#4E74F9"),
          BlendMode.srcIn,
        ),
      ),
      icon: SvgPicture.asset(
        asset,
        width: width,
        height: height,
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class AttendancePage extends StatelessWidget {
  AttendancePage({super.key});

  final controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(54),
        ),
        backgroundColor: HexColor("#4E74F9"),
        foregroundColor: Colors.white,
        tooltip: "Adicionar presença",
        onPressed: () => Get.to(() => AddAttendancePage()),
        child: const Icon(Icons.add_rounded),
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading) {
            return SizedBox(
              height: 64,
              width: 64,
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [HexColor("#4E74F9")],
              ),
            );
          }

          if (controller.attendances.isEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy_rounded,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 8),
                Text(
                  "Nenhuma presença registrada",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: controller.attendances.length,
            itemBuilder: (context, index) {
              return _attendanceCard(controller.attendances[index]);
            },
          );
        }),
      ),
    );
  }

  Widget _attendanceCard(Attendance attendance) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(attendance.date);

    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          formattedDate,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          "Presentes: ${attendance.attendees.length}",
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ver detalhes",
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: HexColor("#6F6F79"),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              color: HexColor("#6F6F79"),
              size: 12,
            ),
          ],
        ),
        leading: SvgPicture.asset(
          "assets/icons/library.svg",
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            HexColor("#4E74F9"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class NotesPage extends StatelessWidget {
  NotesPage({super.key});

  final controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(54),
        ),
        backgroundColor: HexColor("#4E74F9"),
        foregroundColor: Colors.white,
        tooltip: "Adicionar anotação",
        onPressed: () async {
          final text = await textDialog(
            title: "Nova anotação",
            confirmText: "Salvar",
          );

          if (text != null) {
            controller.addNote(text);
          }
        },
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Center(
        child: Obx(() {
          if (controller.isLoading) {
            return SizedBox(
              height: 64,
              width: 64,
              child: LoadingIndicator(
                indicatorType: Indicator.circleStrokeSpin,
                colors: [HexColor("#4E74F9")],
              ),
            );
          }

          if (controller.notes.isEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy_rounded,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 8),
                Text(
                  "Nenhuma anotação registrada",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              return _noteCard(controller.notes[index]);
            },
          );
        }),
      ),
    );
  }

  Widget _noteCard(Note note) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(note.createdAt);
    final String dateHour = DateFormat('HH:mm').format(note.createdAt);

    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          note.title,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          "$formattedDate às $dateHour",
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ver detalhes",
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: HexColor("#6F6F79"),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              color: HexColor("#6F6F79"),
              size: 12,
            ),
          ],
        ),
        leading: Icon(
          Icons.note_rounded,
          color: HexColor("#4E74F9"),
          size: 24,
        ),
      ),
    );
  }
}

class ExamsPage extends StatelessWidget {
  ExamsPage({super.key});

  final controller = Get.put(ExamsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isConsolidating,
        color: Colors.white.withOpacity(0.5),
        progressIndicator: SizedBox(
          width: 80,
          height: 80,
          child: LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: [
              HexColor("#4E74F9"),
            ],
          ),
        ),
        child: Scaffold(
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: HexColor("#4E74F9"),
            foregroundColor: Colors.white,
            spaceBetweenChildren: 12,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add_rounded),
                backgroundColor: HexColor("#E8F2FF"),
                foregroundColor: HexColor("#4E74F9"),
                label: "Adicionar avaliação",
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labelBackgroundColor: Colors.transparent,
                labelShadow: [],
                onTap: () => Get.to(() => AddExamPage()),
              ),
              SpeedDialChild(
                child: SvgPicture.asset(
                  "assets/icons/class_management/consolidate.svg",
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    HexColor("#4E74F9"),
                    BlendMode.srcIn,
                  ),
                ),
                backgroundColor: HexColor("#E8F2FF"),
                label: "Consolidar notas",
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labelBackgroundColor: Colors.transparent,
                labelShadow: [],
                onTap: () async {
                  final confirm = await confirmDialog2(
                    title: "Consolidar notas",
                    content: "Deseja consolidar as notas desta turma?",
                    confirmText: "Consolidar",
                    confirmColor: HexColor("#4E74F9"),
                  );

                  if (confirm) {
                    controller.consolidateGrades();
                  }
                },
              ),
            ],
          ),
          body: Center(
            child: Obx(() {
              if (controller.isLoading) {
                return SizedBox(
                  height: 64,
                  width: 64,
                  child: LoadingIndicator(
                    indicatorType: Indicator.circleStrokeSpin,
                    colors: [HexColor("#4E74F9")],
                  ),
                );
              }

              if (controller.exams.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy_rounded,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Nenhuma avaliação registrada",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                itemCount: controller.exams.length,
                itemBuilder: (context, index) {
                  return _examCard(controller.exams[index]);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _examCard(Exam exam) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(exam.date);

    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          exam.title,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          formattedDate,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ver detalhes",
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: HexColor("#6F6F79"),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward_ios,
              color: HexColor("#6F6F79"),
              size: 12,
            ),
          ],
        ),
        leading: Icon(
          Icons.assignment_rounded,
          color: HexColor("#4E74F9"),
          size: 24,
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final controller = Get.find<ClassManagementController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.className,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Criada em: ${formatDate(controller.classCreatedAt)}",
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: HexColor("#787878")),
          ),
          const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CompactButton(
                  text: "Editar turma",
                  fontSize: 13,
                  onPressed: () {},
                  color: HexColor("#4E74F9"),
                  height: 38,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Excluir turma",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#FF4D4D"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          const Divider(
            indent: 56,
            endIndent: 56,
          ),
          const SizedBox(height: 36),
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Habilitar notificações push",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 8),
                beta(),
              ],
            ),
            trailing: Obx(
              () => AbsorbPointer(
                absorbing: controller.isLoading,
                child: AdvancedSwitch(
                  activeColor: HexColor("#4E74F9"),
                  controller: controller.switchController,
                  onChanged: controller.onChanged,
                  height: 24,
                  width: 48,
                  thumb: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: controller.isLoading
                        ? SizedBox(
                            height: 14,
                            width: 14,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballSpinFadeLoader,
                              colors: controller.switchController.value
                                  ? [HexColor("#4E74F9")]
                                  : [HexColor("#9E9E9E")],
                            ),
                          )
                        : Icon(
                            controller.switchController.value
                                ? Icons.check_rounded
                                : Icons.close_rounded,
                            color: controller.switchController.value
                                ? HexColor("#4E74F9")
                                : HexColor("#9E9E9E"),
                            size: 16,
                          ),
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: HexColor("#E0E0E0"),
                width: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Widget beta() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: HexColor("#4E74F9"),
          width: 1,
        ),
      ),
      child: Text(
        "BETA",
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: HexColor("#4E74F9"),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
