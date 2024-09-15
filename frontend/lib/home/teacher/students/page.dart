import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/students/controller.dart';
import 'package:frontend/home/teacher/students/create/page.dart';
import 'package:frontend/home/teacher/students/info/page.dart';
import 'package:get/get.dart';

class StudentsPage extends StatelessWidget {
  final _controller = Get.put(StudentsController());

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
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (_controller.alunos.isEmpty) {
            return const Center(
              child: Text('Nenhum aluno encontrado'),
            );
          }
          return ListView.builder(
            itemCount: _controller.alunos.length,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).colorScheme.primaryFixed,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () => Get.to(
                    () => StudentInfoPage(aluno: _controller.alunos[index]),
                  ),
                  title: Text(_controller.alunos[index].nome),
                  subtitle:
                      Text('Situacao: ${_controller.alunos[index].situacao}'),
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
          );
        }
      }),
    );
  }
}
