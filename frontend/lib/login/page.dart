import 'package:flutter/material.dart';
import 'package:frontend/home/student/page.dart';
import 'package:frontend/home/teacher/page.dart';
import 'package:frontend/login/entities.dart';
import 'package:frontend/login/controller.dart';
import 'package:frontend/login/widgets.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final service = Get.put(LoginController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "A senha não pode estar vazia";
    }

    if (value.trim().isEmpty) {
      return "A senha não pode conter apenas espaços em branco";
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "O email não pode estar vazio";
    }

    if (value.trim().isEmpty) {
      return "O email não pode conter apenas espaços em branco";
    }

    return GetUtils.isEmail(value) ? null : "Insira um email válido";
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      User? user = await service.auth(
        _emailController.text,
        _passwordController.text,
      );

      if (user == null && mounted) {
        await Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Login inválido",
              textAlign: TextAlign.center,
            ),
            content: const Text(
              "Email ou senha incorretos. Por favor, tente novamente.",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }

      switch (user?.role) {
        case Role.teacher:
          Get.off(() => const TeacherHomePage());
          break;
        case Role.student:
          Get.off(() => const StudentHomePage());
          break;
        default:
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Professor",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                Obx(
                  () => LoginTextField(
                    hintText: "Email",
                    controller: _emailController,
                    validator: validateEmail,
                    enabled: !service.isLoading,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => PasswordTextField(
                    hintText: "Senha",
                    controller: _passwordController,
                    validator: validatePassword,
                    enabled: !service.isLoading,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: service.isChecked,
                            onChanged: (bool? value) => {
                              service.checked = value ?? false,
                            },
                            shape: const CircleBorder(),
                            visualDensity: VisualDensity.compact,
                          ),
                          GestureDetector(
                            onTap: service.notChecked,
                            child: const Text(
                              "Lembrar",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          shadows: [
                            Shadow(
                              color: Colors.grey[600] ?? Colors.grey,
                              offset: const Offset(0, -3),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: service.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Entrar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
