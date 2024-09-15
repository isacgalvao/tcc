import 'package:flutter/material.dart';
import 'package:frontend/role/page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          TextButton(
            child: const Text(
              "Sair",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              final storage = Get.find<GetStorage>();
              storage.remove('nome');
              storage.remove('role');
              storage.remove('id');

              Get.offAll(() => const RolePage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Get.defaultDialog(
                  contentPadding: const EdgeInsets.all(8),
                  titlePadding: const EdgeInsets.all(16),
                  title: "Recurso ainda não implementado",
                  content: const Text(
                    "Ainda não é possível alterar a foto de perfil.",
                  ),
                ),
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.to(() => ChangePasswordPage()),
                    child: const Text('Alterar Senha'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para salvar as alterações
                      Get.to(() => ChangePasswordPage());
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  ChangePasswordPage({super.key});

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // Aqui você deve adicionar a lógica para verificar a senha atual
      // e atualizar a senha para a nova senha.
      // Por exemplo:
      // if (verifyCurrentPassword(_currentPasswordController.text)) {
      //   updatePassword(_newPasswordController.text);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Senha alterada com sucesso!')),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Senha atual incorreta!')),
      //   );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(labelText: 'Senha Atual'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha atual';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'Nova Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a nova senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text('Alterar Senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
