import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/create/widgets.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:get/get.dart';

class CreateClassPage extends StatelessWidget {
  final _turmaController = TextEditingController();
  final _disciplinaController = TextEditingController();

  CreateClassPage({super.key});

  final RxList<Aluno> alunos = <Aluno>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar turma'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => Get.back(),
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
            const SizedBox(height: 32),
            CustomFormField(
              label: 'Disciplina',
              controller: _disciplinaController,
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () => Get.to(
                () => AddStudentsPage(alunosSelecionados: alunos),
              ),
              child: const Text('+  Adicionar alunos'),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: alunos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(alunos[index].nome),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () => alunos.removeAt(index),
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

  final List<Aluno> alunos = [
    Aluno(id: 1, nome: 'Aluno 1', turmas: List.empty()),
    Aluno(id: 2, nome: 'Aluno 2', turmas: List.empty()),
    Aluno(id: 3, nome: 'Aluno 3', turmas: List.empty()),
  ];

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
              var result = await showSearch(
                context: context,
                delegate: StudentSearchDelegate(
                  alunos: alunos,
                  searchFieldLabel: 'Pesquisar alunos',
                ),
              );
              if (result != null) {
                alunosSelecionados.add(result);
              }
            },
            tooltip: 'Pesqusiar alunos',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          return Obx(
            () => CheckboxListTile(
              title: Text(alunos[index].nome),
              value: alunosSelecionados.contains(alunos[index]),
              onChanged: (value) {
                if (value!) {
                  alunosSelecionados.add(alunos[index]);
                } else {
                  alunosSelecionados.remove(alunos[index]);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class StudentSearchDelegate extends SearchDelegate {
  final List<Aluno> alunos;

  StudentSearchDelegate({super.searchFieldLabel, required this.alunos});

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
    return ListView.builder(
      itemCount: alunos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(alunos[index].nome),
          onTap: () {
            close(context, alunos[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Aluno> suggestionList = query.isEmpty
        ? alunos
        : alunos
            .where((element) =>
                element.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].nome),
          onTap: () {
            close(context, suggestionList[index]);
          },
          trailing: const Icon(Icons.add_rounded),
        );
      },
    );
  }
}
