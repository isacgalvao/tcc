import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/class/controller.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class _Controller extends GetxController {
  late final alunos = <Aluno>[].obs;

  final Rx<DateTime> date = DateTime.now().obs;
  final presentes = <Aluno>[].obs;
  final justificativas = <Aluno, String>{}.obs;

  final isLoading = false.obs;

  final _controller = Get.find<AttendanceController>();

  @override
  void onInit() {
    super.onInit();
    loadStudents();
  }

  loadStudents() async {
    isLoading(true);
    try {
      final alunos = await _controller.getStudents();
      this.alunos.addAll(alunos);
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveAttendance() async {
    final attendances = presentes.map((aluno) {
      final justificativa = justificativas[aluno];
      final dto = {
        'data': DateFormat('dd/MM/yyyy HH:mm:ss').format(date.value),
        'alunoId': aluno.id,
      };

      if (justificativa != null) {
        dto['justificativa'] = justificativa;
      }

      return dto;
    }).toList();

    var res = await _controller.classClient.saveAttendance(attendances);

    if (res.status.hasError) {
      await Get.snackbar(
        'Erro',
        'Erro ao salvar as presenças',
        backgroundColor: Colors.red.withOpacity(0.8),
      ).future;
    }
  }
}

class AttendancePage extends StatelessWidget {
  AttendancePage({super.key});

  final _controller = Get.put(_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Presença",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Obx(() {
                  final formattedDate = DateFormat('dd/MM/yyyy').format(
                    _controller.date.value,
                  );
                  final today = DateTime.now();
                  final isToday = DateTime(
                        _controller.date.value.year,
                        _controller.date.value.month,
                        _controller.date.value.day,
                      ) ==
                      DateTime(
                        today.year,
                        today.month,
                        today.day,
                      );
                  return Text(
                    'Data selecionada: ${isToday ? 'Hoje' : formattedDate}',
                  );
                }),
                onPressed: () async {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                    locale: const Locale('pt', 'BR'),
                  ).then((value) {
                    if (value != null) {
                      _controller.date.value = value;
                    }
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_controller.alunos.isEmpty) {
                return const Center(
                  child: Text('Nenhum aluno encontrado'),
                );
              }

              return ListView.builder(
                itemCount: _controller.alunos.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => CheckboxListTile(
                      title: Text(_controller.alunos[index].nome),
                      value: _controller.presentes
                          .contains(_controller.alunos[index]),
                      onChanged: (value) {
                        if (value == true) {
                          _controller.presentes.add(_controller.alunos[index]);
                        } else {
                          _controller.justificativas
                              .remove(_controller.alunos[index]);
                          _controller.presentes
                              .remove(_controller.alunos[index]);
                        }
                      },
                      secondary: IconButton(
                        onPressed: () async {
                          final reasonController = TextEditingController(
                            text: _controller.justificativas[
                                    _controller.alunos[index]] ??
                                '',
                          );
                          await Get.defaultDialog(
                            contentPadding: const EdgeInsets.all(24),
                            title: 'Justificar falta',
                            content: TextField(
                              controller: reasonController,
                              decoration: const InputDecoration(
                                labelText: 'Motivo',
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  reasonController.clear();
                                  Get.back();
                                },
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (reasonController.text.isEmpty) {
                                    Get.snackbar(
                                      'Erro',
                                      'O motivo não pode estar vazio',
                                      backgroundColor:
                                          Colors.red.withOpacity(0.8),
                                    );
                                  } else {
                                    _controller.justificativas[_controller
                                        .alunos[index]] = reasonController.text;
                                    if (!_controller.presentes
                                        .contains(_controller.alunos[index])) {
                                      _controller.presentes
                                          .add(_controller.alunos[index]);
                                    }
                                    Get.back();
                                  }
                                },
                                child: const Text('Justificar'),
                              ),
                            ],
                          );
                        },
                        icon: const Icon(Icons.info_outline),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          child: const Text('Lançar presença'),
          onPressed: () async {
            await loading(_controller.saveAttendance);
            _controller._controller.getAttendances();
            Get.back();
          },
        ),
      ),
    );
  }
}
