import 'package:flutter/material.dart';
import 'package:frontend/controllers/recovery_password_controller.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecoveryPasswordPage extends StatelessWidget {
  RecoveryPasswordPage({super.key});

  final controller = Get.put(RecoveryPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esqueceu sua senha?',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Digite o e-mail vinculado a sua conta no campo abaixo',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: HexColor("#6C7072"),
                  ),
                ),
                const SizedBox(height: 48),
                EmailFormField(
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: 48),
                TeacherButton(
                  text: 'Recuperar senha',
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      await controller.sendEmail();
                      Get.back();
                      successSnackbar(
                        'E-mail enviado com sucesso!',
                        'Verifique sua caixa de entrada',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
