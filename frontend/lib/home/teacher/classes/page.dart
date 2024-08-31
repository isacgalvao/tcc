import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/class/page.dart';
import 'package:frontend/home/teacher/classes/create/page.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:get/get.dart';

class ClassesPage extends StatelessWidget {
  final List<Turma> turmas = [
    Turma(nome: 'Turma 1', disciplina: 'Matemát', quantidadeAlunos: 10),
    Turma(nome: 'Turma 2', disciplina: 'Português', quantidadeAlunos: 15),
    Turma(nome: 'Turma 3', disciplina: 'História', quantidadeAlunos: 20),
    Turma(nome: 'Turma 4', disciplina: 'Geografia', quantidadeAlunos: 25),
    Turma(nome: 'Turma 5', disciplina: 'Física', quantidadeAlunos: 30),
  ];

  ClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas turmas'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
            tooltip: 'Filtrar lista',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => CreateClassPage()),
        tooltip: 'Criar turma',
        icon: const Icon(Icons.add),
        label: const Text("Criar turma"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: turmas.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_rounded, size: 64),
                    Text('Nenhuma turma cadastrada'),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: turmas.length,
                itemBuilder: (context, index) {
                  final turma = turmas[index];
                  return Card(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () => Get.to(() => ClassPage(turma: turma)),
                      title: Text(turma.nome),
                      subtitle: Text(turma.disciplina),
                      trailing: Text('${turma.quantidadeAlunos} alunos'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
