import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/class/attendance/page.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:get/get.dart';

class ClassPage extends StatelessWidget {
  final Turma turma;

  ClassPage({super.key, required this.turma});

  final _selectedIndex = 0.obs;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${turma.nome} (${turma.disciplina})",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex.value,
          onTap: (value) => _pageController.jumpToPage(value),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Presença",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Anotações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Avaliações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _selectedIndex.value = index;
        },
        children: [
          PresencaPage(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
        ],
      ),
    );
  }
}

class PresencaPage extends StatelessWidget {
  final presencas = [];

  PresencaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => AttendancePage()),
        label: const Text('Adicionar presença'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class NotesPage extends StatelessWidget {
  final anotacoes = [];

  NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text('Adicionar anotação'),
              content: const TextField(
                decoration: InputDecoration(
                  labelText: 'Anotação',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          );
        },
        label: const Text('Adicionar anotação'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
