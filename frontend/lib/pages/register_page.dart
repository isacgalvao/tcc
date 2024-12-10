import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/register_controller.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/user.svg',
                    height: 64,
                    width: 60,
                    colorFilter: ColorFilter.mode(
                      HexColor("#4E74F9"),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Crie sua conta",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: HexColor("#161C2B"),
                    ),
                  ),
                  const SizedBox(height: 22),
                  UserFormField(
                    controller: controller.nameController,
                    validator: controller.validateUsername,
                  ),
                  const SizedBox(height: 22),
                  EmailFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 22),
                  PasswordFormField(
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                    initialObscureText: false,
                  ),
                  const SizedBox(height: 38),
                  CustomButton(
                    userType: UserType.teacher,
                    text: "Criar Conta",
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        Get.snackbar(
                          "Sucesso",
                          "Conta criada com sucesso",
                          backgroundColor: HexColor("#4E74F9"),
                          colorText: Colors.white,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 38),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já tem uma conta?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#161C2B"),
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Text(
                          "Entrar",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#4E74F9"),
                          ),
                        ),
                      ),
                    ],
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
