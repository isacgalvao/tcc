import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/recovery_password_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/teacher_home_page.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final UserType userType;

  LoginPage(this.userType, {super.key});

  final controller = Get.put(LoginController());

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
                  _buildIcon(),
                  const SizedBox(height: 16),
                  _buildTitle(),
                  const SizedBox(height: 28),
                  EmailFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 24),
                  PasswordFormField(
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                  ),
                  const SizedBox(height: 24),
                  _buildRememberMeRow(),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Login',
                    userType: userType,
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        await Future.delayed(const Duration(seconds: 2));
                        Get.off(
                          () => userType == UserType.teacher
                              ? TeacherHomePage()
                              : Container(),
                          transition: Transition.rightToLeft,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 54),
                  _buildRegisterRow()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      children: [
        Obx(
          () => AdvancedSwitch(
            initialValue: controller.remember,
            onChanged: controller.toggleRemember,
            activeColor: userType == UserType.teacher
                ? HexColor("#4E74F9")
                : HexColor("#01B6CB"),
            width: 50,
            height: 20,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Lembrar',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: HexColor("#161C2B"),
          ),
        ),
        const Spacer(),
        if (userType == UserType.teacher)
          TextButton(
            onPressed: () => Get.to(
              () => RecoveryPasswordPage(),
              transition: Transition.rightToLeft,
            ),
            child: Text(
              'Esqueceu a senha?',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: HexColor("#161C2B"),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      userType == UserType.teacher
          ? 'Entrar como professor'
          : 'Entrar como aluno',
      style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: HexColor("#161C2B")),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      'assets/icons/user.svg',
      height: 64,
      width: 60,
      colorFilter: ColorFilter.mode(
        userType == UserType.teacher
            ? HexColor("#4E74F9")
            : HexColor("#01B6CB"),
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildRegisterRow() {
    if (userType == UserType.teacher) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ainda não tem conta?',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: HexColor("#161C2B"),
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () => Get.to(
              () => RegisterPage(),
              transition: Transition.rightToLeft,
            ),
            child: Text(
              'Crie uma',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: userType == UserType.teacher
                    ? HexColor("#4E74F9")
                    : HexColor("#01B6CB"),
              ),
            ),
          )
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
