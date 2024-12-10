import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/create_class_controller.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/card.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CreateClassPage extends StatelessWidget {
  CreateClassPage({super.key});

  final controller = Get.put(CreateClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar turma',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: HexColor("#161C2B"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/library.svg',
                  width: 66,
                  height: 60,
                  colorFilter: ColorFilter.mode(
                    HexColor("#4E74F9"),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 56),
                ClassFormField(
                  controller: controller.classNameController,
                  validator: controller.validateClassName,
                ),
                const SizedBox(height: 22),
                SubjectFormField(
                  controller: controller.subjectController,
                  validator: controller.validateSubject,
                ),
                const SizedBox(height: 22),
                const Divider(indent: 16, endIndent: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alunos adicionados a turma',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: HexColor("#6F6F79"),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_rounded,
                        color: HexColor("#4E74F9"),
                      ),
                      onPressed: () => addStudents(context),
                    ).animate(
                      onComplete: (controller) => controller.repeat(
                        reverse: true,
                      ),
                    ).fade(
                      begin: 1.0,
                      end: 0.5,
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 2000),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (controller.students.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_off_outlined,
                            size: 60,
                            color: HexColor("#6F6F79").withOpacity(0.5),
                          ),
                          Text(
                            'Nenhum aluno adicionado',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: HexColor("#6F6F79").withOpacity(0.5),
                            ),
                          ),
                        ],
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.students.length,
                      itemBuilder: (context, index) => StudentCard(
                        controller.students[index],
                      ),
                    );
                  }),
                ),
                const Divider(indent: 16, endIndent: 16),
                const SizedBox(height: 22),
                TeacherButton(
                  text: 'Adicionar turma',
                  onPressed: controller.createClass,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addStudents(BuildContext context) async {
    final student = await showSearch(
      context: context,
      delegate: StudentSearchDelegate(controller.students),
    );

    if (student != null) {
      controller.students.add(student);
    }
  }
}

class StudentSearchDelegate extends SearchDelegate<Student?> {
  final controller = Get.put(SearchStudentController());

  StudentSearchDelegate(List<Student> selectedStudents) {
    controller.selectedStudents = selectedStudents;
  }

  @override
  String get searchFieldLabel => 'Buscar alunos';

  @override
  TextStyle? get searchFieldStyle => GoogleFonts.poppins(
        fontSize: 16,
        color: HexColor("#6F6F79"),
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear_rounded,
          color: HexColor("#6F6F79"),
        ),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_rounded,
        color: HexColor("#6F6F79"),
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return search(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return search(context);
  }

  Widget search(BuildContext context) {
    controller.searchStudents(query);
    return Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
            ),
          ),
        );
      }

      if (controller.students.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_off_outlined,
                size: 60,
                color: HexColor("#6F6F79").withOpacity(0.5),
              ),
              Text(
                'Nenhum aluno encontrado',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#6F6F79").withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            return StudentResultCard(
              isSelected: controller.selectedStudents.contains(
                controller.students[index],
              ),
              student: controller.students[index],
              onTap: () => close(context, controller.students[index]),
            );
          },
        ),
      );
    });
  }
}
