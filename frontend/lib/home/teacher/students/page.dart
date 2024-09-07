import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:frontend/home/teacher/students/create/page.dart';
import 'package:frontend/home/teacher/students/info/page.dart';
import 'package:get/get.dart';

class StudentsPage extends StatelessWidget {
  final alunos = [
    const Aluno(id: 1, nome: "Aluno 1", turmas: []),
    const Aluno(id: 2, nome: "Aluno 2", turmas: []),
    const Aluno(id: 3, nome: "Aluno 3", turmas: []),
  ];

  StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus alunos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => CreateStudentPage()),
        tooltip: 'Adicionar aluno',
        icon: const Icon(Icons.person_add),
        label: const Text('Adicionar aluno'),
      ),
      body: ListView.builder(
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          return Card(
            color: Theme.of(context).colorScheme.primaryFixed,
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () => Get.to(() => StudentInfoPage(aluno: alunos[index])),
              title: Text(alunos[index].nome),
              subtitle: Text('Situacao: Regular'),
              trailing: const Text(
                'Ver detalhes',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Image.asset(
                'assets/profile.png',
                width: 48,
                height: 48,
              ),
            ),
          );
        },
      ),
    );
  }
}
