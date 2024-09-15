import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:frontend/home/teacher/class/attendance/page.dart';
import 'package:frontend/home/teacher/class/entities.dart';
import 'package:frontend/home/teacher/class/exam/page.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          _selectedIndex.value = index;
        },
        children: [
          PresencaPage(),
          NotesPage(),
          ExamPage(),
          const SettingsPage(),
        ],
      ),
    );
  }
}

class PresencaPage extends StatelessWidget {
  final presencas = <Attendance>[
    Attendance.of(
      data: DateTime.now(),
      aluno: Aluno.random(),
      presente: true.obs,
      turma: Turma.empty(),
    ),
  ];

  PresencaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => AttendancePage()),
        label: const Text('Adicionar presença'),
        icon: const Icon(Icons.add),
      ),
      body: presencas.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_rounded, size: 64),
                  Text('Nenhuma presença cadastrada'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: presencas.length,
              itemBuilder: (context, index) {
                final presenca = presencas[index];
                return Card(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () => Get.to(() => AttendancePage()),
                    title: Text(DateFormat("dd/MM/yyyy").format(presenca.data)),
                    subtitle: const Text('Presentes: 26'),
                    trailing: const Icon(Icons.edit),
                  ),
                );
              },
            ),
    );
  }
}

class NotesPage extends StatelessWidget {
  final anotacoes = <Note>[
    Note(
      id: '1',
      title: 'Anotação 1',
      content: 'Conteúdo da anotação 1',
      date: DateTime.now(),
    ),
  ];

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
      body: anotacoes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_rounded, size: 64),
                  Text('Nenhuma anotação cadastrada'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: anotacoes.length,
              itemBuilder: (context, index) {
                final anotacao = anotacoes[index];
                return Card(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Editar anotação'),
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
                              child: const Text('Salvar'),
                            ),
                          ],
                        ),
                      );
                    },
                    title: Text(anotacao.title),
                    subtitle: Text(
                      DateFormat("dd/MM/yyyy").format(anotacao.date),
                    ),
                    trailing: const Icon(Icons.edit),
                  ),
                );
              },
            ),
    );
  }
}

class ExamPage extends StatelessWidget {
  final exams = <Exam>[
    Exam(
      id: 1,
      title: 'Primeira avaliação',
      values: [
        ExamValue(
          id: 1,
          value: 10,
          student: Aluno.random(),
          exam: Exam.empty(),
        ),
      ],
    ),
  ];

  ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Adicionar avaliação',
            onTap: () => Get.to(() => CreateExamPage()),
          ),
          SpeedDialChild(
            child: const Icon(Icons.assignment_turned_in_rounded),
            visible: exams.isNotEmpty,
            label: 'Consolidar notas',
            onTap: () {
              Get.defaultDialog(
                contentPadding: const EdgeInsets.all(16),
                title: 'Consolidar notas',
                content: const Text(
                  'Tem certeza que deseja consolidar as notas?',
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Show loading dialog
                      Get.dialog(
                        const Dialog(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircularProgressIndicator(),
                                Text('Consolidando notas...'),
                              ],
                            ),
                          ),
                        ),
                        barrierDismissible: false,
                      );

                      // Simulate consolidation process
                      await Future.delayed(const Duration(seconds: 1));

                      // Close loading dialog
                      Get.back();
                      Get.back();

                      // Show success message
                      Get.snackbar(
                        'Sucesso',
                        'Consolidação das notas realizada com sucesso!',
                        snackPosition: SnackPosition.TOP,
                        icon: const Icon(Icons.check, color: Colors.white),
                        colorText: Colors.white,
                        backgroundColor: Colors.green,
                        shouldIconPulse: true,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        padding: const EdgeInsets.all(16),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Consolidar notas'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: exams.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_rounded, size: 64),
                  Text('Nenhuma avaliação cadastrada'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                final exam = exams[index];
                return Card(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () => Get.to(() => CreateExamPage()),
                    title: Text(exam.title),
                    subtitle: Text('Alunos: ${exam.values.length}'),
                    trailing: const Icon(Icons.edit),
                  ),
                );
              },
            ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.defaultDialog(
              title: 'Apagar turma',
              content: const Text('Tem certeza que deseja apagar a turma?'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apagar turma'),
                ),
              ],
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Apagar turma'),
        ),
      ),
    );
  }
}
