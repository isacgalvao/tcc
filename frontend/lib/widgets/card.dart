import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:frontend/models/class.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/pages/class_management_page.dart';
import 'package:frontend/pages/class_resume_page.dart';
import 'package:frontend/pages/student_management_page.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/utils/input_formatters.dart';
import 'package:frontend/widgets/dialog.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: utilizar constantes para os valores fixos de cores, tamanhos e textos
// se possível, fazer o mesmo para os outros widgets
class ClassCard extends StatelessWidget {
  final Class _class;

  const ClassCard(
    this._class, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () => Get.to(() => ClassManagementPage(_class)),
        leading: Container(
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          decoration: BoxDecoration(
            color: HexColor(_class.color),
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _class.subject[0].toUpperCase(),
                style: GoogleFonts.dmSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          _class.name,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          _class.subject,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: HexColor("#6F6F79"),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${_class.students.length} ${_class.students.length > 1 ? "alunos" : "aluno"}",
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: HexColor("#6F6F79"),
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios,
              color: HexColor("#6F6F79"),
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class StudentClassCard extends StatelessWidget {
  final Class _class;

  const StudentClassCard(this._class, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 150,
      ),
      child: GestureDetector(
        onTap: () => Get.to(() => ClassResumePage(_class)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: HexColor(_class.color),
                  child: Text(
                    _class.subject[0].toUpperCase(),
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _class.name,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _class.subject,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${_class.students.length} ${_class.students.length > 1 ? "alunos" : "aluno"}",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: HexColor("#6F6F79"),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Get.to(() => ClassResumePage(_class)),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(HexColor("#01B6CB")),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "Ver turma",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student _student;

  const StudentCard(
    this._student, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () => Get.to(() => StudentManagementPage(_student)),
        leading: CircleAvatar(
          backgroundColor: HexColor(_student.color),
          child: Text(
            _student.name[0].toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          _student.name,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          'Situação: ${_student.status.name}',
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: HexColor("#6F6F79"),
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
      ),
    );
  }
}

class StudentResultCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;
  final bool isSelected;

  const StudentResultCard({
    super.key,
    required this.student,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          if (isSelected) {
            attentionSnackbar(
              "Aluno já adicionado",
              "${student.name} já foi adicionado(a) à turma",
            );
          } else {
            onTap();
          }
        },
        leading: CircleAvatar(
          backgroundColor: HexColor(student.color),
          child: Text(
            student.name[0].toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          student.name,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: HexColor("#00C88C"),
                size: 20,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Adicionar",
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
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final Student _student;

  AttendanceCard({
    super.key,
    required Student student,
  }) : _student = student;

  final _switchController = ValueNotifier(false);

  final _isPresent = false.obs;
  final Rx<String?> _justification = Rx(null);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => ListTile(
          tileColor: _isPresent.value ? Colors.green.withOpacity(0.1) : null,
          onTap: toggleSwitch,
          leading: CircleAvatar(
            backgroundColor: HexColor(_student.color),
            child: Text(
              _student.name[0].toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            _student.name,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            'Situação: ${_justification.value != null ? "Justificada" : _isPresent.value ? "Presente" : "Ausente"}',
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: HexColor("#6F6F79"),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdvancedSwitch(
                controller: _switchController,
                activeColor: HexColor("#00C88C"),
                inactiveColor: HexColor("#9E9E9E"),
                width: 40,
                height: 20,
                onChanged: (value) {
                  if (!value) {
                    _justification.value = null;
                  }
                  _isPresent.value = value;
                },
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: 'Justificar falta',
                child: AbsorbPointer(
                  absorbing: _isPresent.value || _justification.value != null,
                  child: GestureDetector(
                    onTap: () async {
                      final text = await textDialog(
                        title: 'Justificar falta',
                        confirmText: 'Justificar',
                      );

                      if (text != null) {
                        _justification.value = text;
                        _switchController.value = true;
                      }
                    },
                    child: _justification.value != null
                        ? Icon(
                            Icons.check_circle,
                            color: HexColor("#00C88C"),
                            size: 20,
                          )
                        : Icon(
                            Icons.info_outline_rounded,
                            color: _isPresent.value
                                ? HexColor("#6F6F79").withOpacity(0.2)
                                : HexColor("#6F6F79"),
                            size: 20,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleSwitch() {
    _switchController.value = !_switchController.value;
  }
}

class ExamCard extends StatelessWidget {
  final Student _student;

  ExamCard(
    this._student, {
    super.key,
  });

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: HexColor(_student.color),
            child: Text(
              _student.name[0].toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            _student.name,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            'Situação: ${_student.status.name}',
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: HexColor("#6F6F79"),
            ),
          ),
          trailing: SizedBox(
            height: 40,
            width: 100,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLength: 2,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                MaxValueInputFormatter(10),
              ],
              decoration: InputDecoration(
                counter: SizedBox.shrink(),
                hintText: 'Nota',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#0C448C"),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: HexColor("#E8F2FF"),
              ),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: HexColor("#0C448C"),
              ),
              keyboardType: TextInputType.number,
            ),
          )),
    );
  }
}

class StudentReportCard extends StatelessWidget {
  final String title;
  final Widget page;

  const StudentReportCard({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        onTap: () => Get.to(() => page),
        leading: CircleAvatar(
          backgroundColor: HexColor("#01B6CB"),
          child: Icon(
            Icons.insert_chart_outlined,
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
