import 'package:flutter/material.dart';
import 'package:frontend/controllers/student_management_controller.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/dialog.dart';
import 'package:frontend/widgets/profile.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

class StudentManagementPage extends StatelessWidget {
  final Student _student;

  late final StudentManagementController controller;

  StudentManagementPage(this._student, {super.key}) {
    controller = Get.put(StudentManagementController(_student));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading,
        color: Colors.white.withOpacity(0.5),
        progressIndicator: SizedBox(
          width: 80,
          height: 80,
          child: LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: [
              HexColor("#4E74F9"),
            ],
          )
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Informações do aluno",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: HexColor("#F94E74"),
                ),
                onPressed: () async {
                  final canDelete = await confirmDialog(
                    title: 'Excluir aluno',
                    content: 'Tem certeza que deseja excluir este aluno?',
                    confirmText: 'Excluir',
                  );

                  if (canDelete) {
                    await controller.deleteStudent();
                  }
                },
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const StudentProfile(),
                      const SizedBox(height: 64),
                      NameFormField(
                        controller: controller.nameController,
                        validator: controller.nameValidator,
                      ),
                      const SizedBox(height: 22),
                      EmailFormField(
                        controller: controller.emailController,
                        validator: (value) => null,
                      ),
                      const SizedBox(height: 22),
                      PhoneFormField(
                        controller: controller.phoneController,
                        validator: (value) => null,
                      ),
                      const SizedBox(height: 22),
                      DateFormField(
                        hintText: 'Data de nascimento',
                        controller: controller.birthDateController,
                        validator: (value) => null,
                      ),
                      const SizedBox(height: 40),
                      TeacherButton(
                        text: 'Salvar alterações',
                        onPressed: controller.updateStudent,
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CompactButton(
                            color: HexColor("#4E74F9"),
                            text: 'Criar acesso',
                            onPressed: () async {
                              final user = await formDialog(
                                title: 'Crie um usuário para o aluno',
                                confirmText: 'Criar',
                              );
                  
                              if (user != null) {
                                await controller.createAccess(user);
                              }
                            },
                          ),
                          CompactButton(
                            color: HexColor("#F94E74"),
                            text: 'Revogar acesso',
                            onPressed: controller.revokeAccess,
                            enabled: false,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
