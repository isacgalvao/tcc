import 'package:flutter/material.dart';
import 'package:frontend/home/student/page.dart';
import 'package:frontend/home/teacher/page.dart';
import 'package:frontend/login/entities.dart';
import 'package:frontend/login/controller.dart';
import 'package:frontend/login/widgets.dart';
import 'package:frontend/register/page.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  final Role role;

  const LoginPage({super.key, required this.role});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _controller = Get.put(LoginController());

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
      return "Não pode estar vazio";
    }

    if (value.trim().isEmpty) {
      return "Não pode conter apenas espaços em branco";
    }

    return null;
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      var user = await _controller.auth(
        _emailController.text,
        _passwordController.text,
      );

      bool telaIncorreta = user['role'].toString().capitalize !=
          widget.role.getRoleDescription();
      if ((user == null || telaIncorreta) && mounted) {
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
              "Email/usuário ou senha incorretos. Por favor, tente novamente.",
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
        return;
      }

      switch (widget.role) {
        case Role.professor:
          Get.offAll(() => TeacherHomePage(
                teacherName: user['nome'],
              ));
          break;
        case Role.aluno:
          Get.offAll(() => StudentHomePage(
                studentName: user['nome'],
              ));
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.role.getRoleDescription(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Obx(
                    () => LoginTextField(
                      hintText: "Email ou usuário",
                      controller: _emailController,
                      validator: validateEmail,
                      enabled: !_controller.isLoading,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => PasswordTextField(
                      hintText: "Senha",
                      controller: _passwordController,
                      validator: validatePassword,
                      enabled: !_controller.isLoading,
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
                              value: _controller.isChecked,
                              onChanged: (bool? value) => {
                                _controller.checked = value ?? false,
                              },
                              shape: const CircleBorder(),
                              visualDensity: VisualDensity.compact,
                            ),
                            GestureDetector(
                              onTap: _controller.notChecked,
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: _controller.isLoading
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
                  ),
                  if (widget.role == Role.professor)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => RegisterPage()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: const Text(
                          "Cadastrar-se",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
