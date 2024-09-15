import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/controller.dart';
import 'package:frontend/home/teacher/classes/create/widgets.dart';
import 'package:frontend/home/teacher/students/controller.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';

class CreateClassPage extends StatelessWidget {
  final _turmaController = TextEditingController();
  final _disciplinaController = TextEditingController();
  final _notaMinimaController = TextEditingController();

  CreateClassPage({super.key});

  final _controller = Get.find<ClassesController>();

  final RxList<Aluno> alunosSelecionados = <Aluno>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar turma'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (alunosSelecionados.isEmpty) {
                Get.snackbar(
                  'Erro',
                  'Adicione pelo menos um aluno',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
                return;
              }

              var res = await loading(
                () => _controller.createClass(
                  _turmaController.text,
                  _disciplinaController.text,
                  double.parse(_notaMinimaController.text.replaceAll(",", ".")),
                  alunosSelecionados.map((e) => e.id).toList(),
                ),
              );

              if (res.isOk) {
                Get.back();
                Get.snackbar(
                  'Sucesso',
                  'Turma criada com sucesso',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              } else {
                Get.snackbar(
                  'Erro',
                  'Erro ao criar turma: ${res.statusCode}',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }
            },
            tooltip: 'Salvar turma',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomFormField(
              label: 'Nome da turma',
              controller: _turmaController,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              label: 'Disciplina',
              controller: _disciplinaController,
            ),
            const SizedBox(height: 16),
            CustomFormField(
              label: 'Nota mínima',
              controller: _notaMinimaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () => Get.to(
                () => AddStudentsPage(alunosSelecionados: alunosSelecionados),
              ),
              child: const Text('+  Adicionar alunos'),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: alunosSelecionados.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(alunosSelecionados[index].nome),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () => alunosSelecionados.removeAt(index),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddStudentsPage extends StatelessWidget {
  final RxList<Aluno> alunosSelecionados;

  AddStudentsPage({super.key, required this.alunosSelecionados});

  final _controller = Get.put(StudentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar alunos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () async {
              Aluno result = await showSearch(
                context: context,
                delegate: StudentSearchDelegate(
                  searchFieldLabel: 'Pesquisar alunos',
                ),
              );
              alunosSelecionados.add(result);
            },
            tooltip: 'Pesqusiar alunos',
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.alunos.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_rounded, size: 64),
                Text('Nenhum aluno cadastrado'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: _controller.alunos.length,
          itemBuilder: (context, index) {
            return Obx(
              () => CheckboxListTile(
                title: Text(_controller.alunos[index].nome),
                value: alunosSelecionados.contains(_controller.alunos[index]),
                onChanged: (value) {
                  if (value!) {
                    alunosSelecionados.add(_controller.alunos[index]);
                  } else {
                    alunosSelecionados.remove(_controller.alunos[index]);
                  }
                },
              ),
            );
          },
        );
      }),
    );
  }
}

class StudentSearchDelegate extends SearchDelegate {
  final _controller = Get.find<StudentsController>();

  StudentSearchDelegate({super.searchFieldLabel});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _controller.searchAlunos(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao buscar alunos: ${snapshot.error}'),
          );
        }

        final List<Aluno> alunos = snapshot.data as List<Aluno>;

        return ListView.builder(
          itemCount: alunos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(alunos[index].nome),
              leading: const Icon(Icons.person_rounded),
              trailing: const Icon(Icons.add_rounded),
              onTap: () {
                close(context, alunos[index]);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _controller.searchAlunos(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao buscar alunos: ${snapshot.error}'),
          );
        }

        final List<Aluno> alunos = snapshot.data as List<Aluno>;

        return ListView.builder(
          itemCount: alunos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(alunos[index].nome),
              leading: const Icon(Icons.person_rounded),
              trailing: const Icon(Icons.add_rounded),
              onTap: () {
                close(context, alunos[index]);
              },
            );
          },
        );
      },
    );
  }
}
