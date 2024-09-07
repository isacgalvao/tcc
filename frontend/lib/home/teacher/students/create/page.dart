import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateStudentPage extends StatelessWidget {
  CreateStudentPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthDateController = TextEditingController();

  final birthDateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  child: Image.asset('assets/profile.png'),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: nameController,
                  label: 'Nome',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: phoneController,
                  label: 'Telefone',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  formatter: phoneMask,
                  maxLength: 25,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: birthDateController,
                  label: 'Data de nascimento',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de nascimento';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.datetime,
                  formatter: birthDateMask,
                  hint: 'dd/mm/aaaa',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          child: const Text('Adicionar aluno'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Implementar lógica de adicionar aluno
              Get.back();
            }
          },
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputFormatter? formatter;
  final String? hint;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.keyboardType,
    this.formatter,
    this.hint,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter != null ? [formatter!] : [],
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
