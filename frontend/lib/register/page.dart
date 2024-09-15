import 'package:flutter/material.dart';
import 'package:frontend/login/widgets.dart';
import 'package:frontend/register/controller.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final _controller = Get.put(RegisterController());

  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "O nome não pode estar vazio";
    }

    if (value.trim().isEmpty) {
      return "O nome não pode conter apenas espaços em branco";
    }

    return null;
  }

  String? _validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return "O usuário não pode estar vazio";
    }

    if (value.trim().isEmpty) {
      return "O usuário não pode conter apenas espaços em branco";
    }

    final regex = RegExp(r'^\w{3,}$');
    if (!regex.hasMatch(value)) {
      return "O usuário deve conter apenas letras, números e _";
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "O email não pode estar vazio";
    }

    if (value.trim().isEmpty) {
      return "O email não pode conter apenas espaços em branco";
    }

    return GetUtils.isEmail(value) ? null : "Insira um email válido";
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "A senha não pode estar vazia";
    }

    if (value.trim().isEmpty) {
      return "A senha não pode conter apenas espaços em branco";
    }

    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "A senha não pode estar vazia";
    }

    if (value.trim().isEmpty) {
      return "A senha não pode conter apenas espaços em branco";
    }

    if (value != _passwordController.text) {
      return "As senhas não coincidem";
    }

    return null;
  }

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      var res = await loading(
        () => _controller.cadastrar(
          nome: _nameController.text,
          email: _emailController.text,
          usuario: _userController.text,
          senha: _passwordController.text,
        ),
      );

      if (res.status.isOk) {
        Get.back();
        Get.snackbar(
          "Sucesso",
          "Usuário cadastrado com sucesso",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else if (res.statusCode == 409) {
        Get.snackbar(
          "Erro",
          res.body['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Erro",
          "Erro ao cadastrar usuário: ${res.body}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
                  const Text(
                    "Cadastro",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 48),
                  LoginTextField(
                    controller: _nameController,
                    hintText: "Nome",
                    validator: _validateName,
                  ),
                  const SizedBox(height: 16),
                  LoginTextField(
                    controller: _userController,
                    hintText: "Usuário",
                    validator: _validateUser,
                  ),
                  const SizedBox(height: 16),
                  LoginTextField(
                    controller: _emailController,
                    hintText: "Email",
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _passwordController,
                    hintText: "Senha",
                    validator: _passwordValidator,
                  ),
                  const SizedBox(height: 16),
                  PasswordTextField(
                    controller: _confirmPasswordController,
                    hintText: "Confirme a senha",
                    validator: _confirmPasswordValidator,
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _cadastrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: Get.back,
                    child: const Text("Voltar"),
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
