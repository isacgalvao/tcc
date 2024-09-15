import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Attendance {
  final int id;
  final Aluno aluno;
  final Turma turma;
  final DateTime data;
  RxBool presente;
  RxString? justificativa;

  String? get justificativaValue => justificativa?.value;
  set justificativaValue(String? value) => justificativa?.value = value!;
  bool get presenteValue => presente.value;
  set presenteValue(bool value) => presente.value = value;

  Attendance({
    required this.id,
    required this.aluno,
    required this.turma,
    required this.data,
    required this.presente,
    this.justificativa,
  });

  Attendance.of({
    required this.aluno,
    required this.turma,
    required this.data,
    required this.presente,
    this.justificativa,
  }) : id = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendance && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class AttendancePage extends StatelessWidget {
  final List<Aluno> alunos = [
    // Aluno(id: 1, nome: 'Aluno 1', turmas: List.empty()),
    // Aluno(id: 2, nome: 'Aluno 2', turmas: List.empty()),
    // Aluno(id: 3, nome: 'Aluno 3', turmas: List.empty()),
  ];

  final Rx<DateTime> date = DateTime.now().obs;

  final RxList<Attendance> attendance = RxList<Attendance>();

  AttendancePage({super.key}) {
    attendance.addAll(alunos
        .map(
          (e) => Attendance.of(
            aluno: e,
            turma: Turma.empty(),
            data: DateTime.now(),
            presente: false.obs,
          ),
        )
        .toList());
  }

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
                    date.value,
                  );
                  final today = DateTime.now();
                  final isToday = DateTime(
                        date.value.year,
                        date.value.month,
                        date.value.day,
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
                      date.value = value;
                    }
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendance.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => CheckboxListTile(
                    tristate: true,
                    title: Text(attendance[index].aluno.nome),
                    value: attendance[index].justificativaValue != null
                        ? null
                        : attendance[index].presenteValue,
                    onChanged: (value) {
                      if (value != null) {
                        attendance[index].presenteValue = value;
                        if (value) {
                          attendance[index].justificativaValue = null;
                        }
                      } else if (attendance[index].justificativaValue == null) {
                        attendance[index].presenteValue = false;
                      }
                    },
                    secondary:
                        JustifyAbsenceDialog(attendance: attendance[index]),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          child: const Text('Lançar presença'),
          onPressed: () {
            // TODO: Implementar lançamento de presença
            Get.back();
          },
        ),
      ),
    );
  }
}

class JustifyAbsenceDialog extends StatelessWidget {
  final Attendance attendance;

  JustifyAbsenceDialog({super.key, required this.attendance});

  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.defaultDialog(
          contentPadding: const EdgeInsets.all(24),
          title: 'Justificar falta',
          content: TextField(
            controller: _reasonController,
            decoration: const InputDecoration(
              labelText: 'Motivo',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _reasonController.clear();
                Get.back();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_reasonController.text.isEmpty) {
                  Get.snackbar(
                    'Erro',
                    'O motivo não pode estar vazio',
                    backgroundColor: Colors.red.withOpacity(0.8),
                  );
                } else {
                  attendance.justificativaValue = _reasonController.text;
                  Get.back();
                }
              },
              child: const Text('Justificar'),
            ),
          ],
        );
      },
      icon: const Icon(Icons.info_outline),
    );
  }
}
