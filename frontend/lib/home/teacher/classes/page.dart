import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/class/page.dart';
import 'package:frontend/home/teacher/classes/controller.dart';
import 'package:frontend/home/teacher/classes/create/page.dart';
import 'package:get/get.dart';

class ClassesPage extends StatelessWidget {
  final _controller = Get.put(ClassesController());

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
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.turmas.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_rounded, size: 64),
                  Text('Nenhuma turma cadastrada'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: _controller.turmas.length,
            itemBuilder: (context, index) {
              final turma = _controller.turmas[index];
              return Card(
                color: Theme.of(context).colorScheme.primaryFixed,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () => Get.to(() => ClassPage(turma: turma)),
                  title: Text('${turma.nome} (${turma.disciplina})'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${turma.alunos.length} alunos'),
                      Text('Situação: ${turma.situacao}'),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
