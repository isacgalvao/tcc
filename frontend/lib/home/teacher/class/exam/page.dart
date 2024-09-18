import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/class/controller.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';

class _Controller extends GetxController {
  final _controller = Get.find<ExamController>();
  final data = DateTime.now();
  final alunos = <Aluno>[].obs;
  final isLoading = false.obs;

  final List<TextEditingController> notaControllers = [];

  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  @override
  void onClose() {
    for (final controller in notaControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  getStudents() async {
    isLoading(true);
    try {
      final response = await _controller.classClient.getStudents();
      if (response.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar alunos',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white),
          shouldIconPulse: true,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          padding: const EdgeInsets.all(16),
        );
      } else {
        final data = response.body as List;
        alunos.assignAll(data.map((e) => Aluno.fromJson(e)).toList());
        notaControllers.assignAll(List.generate(
          alunos.length,
          (index) => TextEditingController(),
        ));
      }
    } finally {
      isLoading(false);
    }
  }

  Future<Response> addExam() {
    final notas = <Map<String, dynamic>>[];
    for (int i = 0; i < alunos.length; i++) {
      notas.add({
        'alunoId': alunos[i].id,
        'valor': double.parse(notaControllers[i].text),
      });
    }
    return _controller.addExam(data, notas);
  }
}

class CreateExamPage extends StatelessWidget {
  final _controller = Get.put(_Controller());

  final formKey = GlobalKey<FormState>();

  CreateExamPage({super.key});

  void adicionarAvaliacao() async {
    if (formKey.currentState!.validate()) {
      var res = await loading(_controller.addExam);

      if (res.isOk) {
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
      } else {
        Get.snackbar(
          'Erro',
          'Erro ao adicionar avaliação',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Avaliação'),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.alunos.isEmpty) {
          return const Center(child: Text('Nenhum aluno encontrado'));
        }

        return Form(
          key: formKey,
          child: ListView.builder(
            itemCount: _controller.alunos.length,
            itemBuilder: (context, index) {
              final aluno = _controller.alunos[index];
              return AlunoNotaWidget(
                nome: aluno.nome,
                notaController: _controller.notaControllers[index],
              );
            },
          ),
        );
      }),
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
