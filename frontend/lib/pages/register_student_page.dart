import 'package:flutter/material.dart';
import 'package:frontend/controllers/register_student_controller.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/profile.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterStudentPage extends StatelessWidget {
  RegisterStudentPage({super.key});

  final controller = Get.put(RegisterStudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar aluno',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
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
                    validator: controller.emailValidator,
                  ),
                  const SizedBox(height: 22),
                  PhoneFormField(
                    controller: controller.phoneController,
                    validator: controller.phoneValidator,
                  ),
                  const SizedBox(height: 22),
                  DateFormField(
                    hintText: 'Data de nascimento',
                    controller: controller.birthDateController,
                    validator: controller.birthDateValidator,
                  ),
                  const SizedBox(height: 40),
                  TeacherButton(
                    text: 'Adicionar aluno',
                    onPressed: controller.registerStudent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
