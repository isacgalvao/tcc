import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:frontend/home/teacher/class/attendance/page.dart';
import 'package:frontend/home/teacher/class/controller.dart';
import 'package:frontend/home/teacher/class/entities.dart';
import 'package:frontend/home/teacher/class/exam/page.dart';
import 'package:frontend/home/teacher/classes/controller.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ClassPage extends StatelessWidget {
  final Turma turma;

  ClassPage({super.key, required this.turma});

  final _selectedIndex = 0.obs;
  final _pageController = PageController();

  Widget inProgressClass() {
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
          PresencaPage(turma),
          NotesPage(turma),
          ExamPage(turma),
          SettingsPage(turma),
        ],
      ),
    );
  }

  Widget finishedClass() {
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
              icon: Icon(Icons.check_circle_rounded),
              label: 'Resultado',
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
          ResultPage(turma),
          SettingsPage(turma),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return turma.finalizada ? finishedClass() : inProgressClass();
  }
}

class ResultPage extends StatelessWidget {
  final Turma turma;

  const ResultPage(this.turma, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: turma.resultadosFinais!.length,
          itemBuilder: (context, index) {
            final resultado = turma.resultadosFinais!.entries.elementAt(index);
            return Card(
              color: Theme.of(context).colorScheme.primaryFixed,
              margin: const EdgeInsets.all(16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(turma.alunos
                    .firstWhere(
                      (aluno) => aluno.id == int.parse(resultado.key),
                    )
                    .nome),
                subtitle: Text('Média: ${resultado.value}'),
                trailing: Text(
                  resultado.value >= turma.notaMinima
                      ? 'Aprovado'
                      : 'Reprovado',
                  style: TextStyle(
                    color: resultado.value >= turma.notaMinima
                        ? Colors.green
                        : Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PresencaPage extends StatelessWidget {
  late final AttendanceController _controller;

  PresencaPage(Turma turma, {super.key}) {
    _controller = Get.put(AttendanceController(turma.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => AttendancePage()),
        label: const Text('Adicionar presença'),
        icon: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Carregando presenças...'),
              ],
            ),
          );
        }

        if (_controller.attendances.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_rounded, size: 64),
                Text('Nenhuma presença cadastrada'),
              ],
            ),
          );
        }

        final grouped = groupBy(
          _controller.attendances,
          (attendance) => attendance.data,
        );

        return ListView.builder(
          itemCount: grouped.length,
          itemBuilder: (context, index) {
            final presenca = grouped.entries.elementAt(index);
            return Card(
              color: Theme.of(context).colorScheme.primaryFixed,
              margin: const EdgeInsets.all(16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text(DateFormat("dd/MM/yyyy").format(presenca.key)),
                subtitle: Text('Presentes: ${presenca.value.length}'),
                trailing: IconButton(
                  onPressed: () async {
                    final canDelete = await Get.defaultDialog(
                      title: 'Deletar presença',
                      content: const Text(
                        'Tem certeza que deseja deletar a presença?',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back(result: true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Deletar'),
                        ),
                      ],
                    );

                    if (canDelete) {
                      final hasError = await loading(
                        () => _controller.deleteAttendance(presenca.value),
                      );
                      if (hasError) {
                        Get.snackbar(
                          'Erro',
                          'Erro ao deletar a presença',
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                        );
                      } else {
                        Get.snackbar(
                          'Sucesso',
                          'Presença deletada com sucesso',
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class NoteDialog extends StatelessWidget {
  final Note? note;

  NoteDialog({super.key, this.note}) {
    if (note != null) {
      noteController.text = note!.conteudo;
    }
  }

  final noteController = TextEditingController();
  final _controller = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar anotação'),
      content: TextField(
        controller: noteController,
        decoration: const InputDecoration(
          labelText: 'Anotação',
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            if (noteController.text.isEmpty) {
              Get.snackbar(
                'Erro',
                'O campo anotação não pode estar vazio',
                colorText: Colors.white,
                backgroundColor: Colors.red,
              );
              return;
            }

            var res = await loading(
              () => note != null
                  ? _controller.updateNote(note!.id, noteController.text)
                  : _controller.addNote(noteController.text),
            );

            if (res.isOk) {
              Get.back();
              Get.snackbar(
                'Sucesso',
                note != null
                    ? 'Anotação atualizada com sucesso'
                    : 'Anotação adicionada com sucesso',
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
            } else {
              Get.snackbar(
                'Erro',
                note != null
                    ? 'Erro ao atualizar anotação'
                    : 'Erro ao adicionar anotação',
                snackPosition: SnackPosition.TOP,
                icon: const Icon(Icons.error, color: Colors.white),
                colorText: Colors.white,
                backgroundColor: Colors.red,
                shouldIconPulse: true,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                padding: const EdgeInsets.all(16),
              );
            }
          },
          child:
              note != null ? const Text("Atualizar") : const Text('Adicionar'),
        ),
      ],
    );
  }
}

class NotesPage extends StatelessWidget {
  late final NotesController _controller;

  NotesPage(Turma turma, {super.key}) {
    _controller = Get.put(NotesController(turma.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.dialog(NoteDialog()),
        label: const Text('Adicionar anotação'),
        icon: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Carregando anotações...'),
              ],
            ),
          );
        }

        if (_controller.notes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_rounded, size: 64),
                Text('Nenhuma anotação cadastrada'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: _controller.notes.length,
          itemBuilder: (context, index) {
            final anotacao = _controller.notes[index];
            return Card(
              color: Theme.of(context).colorScheme.primaryFixed,
              margin: const EdgeInsets.all(16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onTap: () => Get.dialog(NoteDialog(note: anotacao)),
                title: Text('Anotação ${index + 1}'),
                subtitle: Text(
                  DateFormat("dd/MM/yyyy HH:mm").format(anotacao.data),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    final canDelete = await Get.defaultDialog(
                      title: 'Remover anotação',
                      content: const Text(
                        'Tem certeza que deseja remover a anotação?',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back(result: true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Deletar'),
                        ),
                      ],
                    );

                    if (canDelete) {
                      var res = await loading(
                        () => _controller.deleteNote(anotacao.id),
                      );

                      if (res.isOk) {
                        Get.snackbar(
                          'Sucesso',
                          'Anotação removida com sucesso',
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
                      } else {
                        Get.snackbar(
                          'Erro',
                          'Ocorreu um erro ao remover a anotação',
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class ExamPage extends StatelessWidget {
  late final ExamController _controller;

  ExamPage(Turma turma, {super.key}) {
    _controller = Get.put(ExamController(turma.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => SpeedDial(
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
              visible: _controller.exams.isNotEmpty,
              label: 'Consolidar notas',
              onTap: () async {
                final result = await Get.defaultDialog(
                  contentPadding: const EdgeInsets.all(16),
                  title: 'Consolidar notas',
                  content: const Text(
                    'Tem certeza que deseja consolidar as notas?',
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Consolidar notas'),
                    ),
                  ],
                );

                if (result) {
                  var res = await loading(
                    _controller.consolidarNotas,
                    title: "Consolidando notas...",
                  );

                  if (res.isOk) {
                    final classesController = Get.find<ClassesController>();
                    await loading(classesController.getClasses);
                    Turma turma = classesController.turmas.firstWhere(
                      (element) => element.id == _controller.turmaId,
                    );
                    Get.back();
                    Get.to(() => ClassPage(turma: turma));
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
                  } else {
                    Get.snackbar(
                      'Erro',
                      'Erro ao consolidar as notas',
                      snackPosition: SnackPosition.TOP,
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Carregando avaliações...'),
              ],
            ),
          );
        }

        if (_controller.exams.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_rounded, size: 64),
                Text('Nenhuma avaliação cadastrada'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: _controller.exams.length,
          itemBuilder: (context, index) {
            final exam = _controller.exams[index];
            return Card(
              color: Theme.of(context).colorScheme.primaryFixed,
              margin: const EdgeInsets.all(16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text('Avaliação ${index + 1}'),
                subtitle: Text('Alunos: ${exam.notas.length}'),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    final canDelete = await Get.defaultDialog(
                      title: 'Remover avaliação',
                      content: const Text(
                        'Tem certeza que deseja remover a avaliação?',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Remover'),
                        ),
                      ],
                    );

                    if (canDelete) {
                      var res = await loading(
                        () => _controller.deleteExam(exam.id),
                      );

                      if (res.isOk) {
                        Get.snackbar(
                          'Sucesso',
                          'Avaliação removida com sucesso',
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
                      } else {
                        Get.snackbar(
                          'Erro',
                          'Erro ao remover a avaliação',
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class SettingsPage extends StatelessWidget {
  late final ClassClient classClient;

  SettingsPage(Turma turma, {super.key}) {
    classClient = Get.put(
      ClassClient(Get.find<GetStorage>().read("id"), turma.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final canDelete = await Get.defaultDialog(
              title: 'Apagar turma',
              content: const Text('Tem certeza que deseja apagar a turma?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apagar turma'),
                ),
              ],
              onWillPop: () async => false,
            );

            if (canDelete) {
              var res = await loading(() => classClient.deleteClass());

              Get.find<ClassesController>().getClasses();

              if (res.isOk) {
                Get.back();
                Get.snackbar(
                  'Sucesso',
                  'Turma apagada com sucesso',
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
              } else {
                Get.snackbar(
                  'Erro',
                  'Erro ao apagar a turma',
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                );
              }
            }
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
