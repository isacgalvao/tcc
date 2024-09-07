import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:get/get.dart';

class CreateExamPage extends StatelessWidget {
  final alunos = [
    const Aluno(
      id: 1,
      nome: 'Aluno 1',
      turmas: [],
    ),
    const Aluno(
      id: 2,
      nome: 'Aluno 2',
      turmas: [],
    ),
    const Aluno(
      id: 3,
      nome: 'Aluno 3',
      turmas: [],
    ),
  ];

  final List<TextEditingController> notaControllers = [];
  final formKey = GlobalKey<FormState>();

  CreateExamPage({super.key}) {
    for (var _ in alunos) {
      notaControllers.add(TextEditingController());
    }
  }

  void adicionarAvaliacao() {
    if (formKey.currentState!.validate()) {
      // TODO: Implementar a lógica de adicionar avaliação
      Get.back();
      Get.snackbar(
        'Sucesso',
        'Avaliação adicionada com sucesso',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check, color: Colors.white),
        shouldIconPulse: true,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        padding: const EdgeInsets.all(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Avaliação'),
      ),
      body: Form(
        key: formKey,
        child: ListView.builder(
          itemCount: alunos.length,
          itemBuilder: (context, index) {
            final aluno = alunos[index];
            return AlunoNotaWidget(
              nome: aluno.nome,
              notaController: notaControllers[index],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: adicionarAvaliacao,
          child: const Text('Adicionar Avaliação'),
        ),
      ),
    );
  }
}

class AlunoNotaWidget extends StatelessWidget {
  final String nome;
  final TextEditingController notaController;

  const AlunoNotaWidget({
    super.key,
    required this.nome,
    required this.notaController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 8),
          Text(nome),
          const Spacer(),
          SizedBox(
            width: 100,
            child: TextFormField(
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha';
                }

                return null;
              },
              controller: notaController,
              decoration: InputDecoration(
                helperText: "",
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Nota',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
