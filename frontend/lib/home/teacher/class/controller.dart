import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/class/entities.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ClassClient extends GetConnect {
  final int professorId;
  final int turmaId;

  ClassClient(this.professorId, this.turmaId);

  @override
  void onInit() {
    httpClient.baseUrl = 'https://sistema-escolar-a247d51c11b7.herokuapp.com';
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response> getAttendances() => get(
        '/professor/$professorId/turmas/$turmaId/presencas',
      );

  Future<Response> getStudents() => get(
        '/professor/$professorId/turmas/$turmaId/alunos',
      );

  Future<Response> saveAttendance(List<Map<String, dynamic>> attendances) =>
      post(
        '/professor/$professorId/turmas/$turmaId/presencas',
        attendances,
      );

  Future<Response> deleteAttendance(int id) => delete(
        '/professor/$professorId/turmas/$turmaId/presencas/$id',
      );

  Future<Response> getNotes() => get(
        "/professor/$professorId/turmas/$turmaId/anotacoes",
      );

  Future<Response> createNote(String content) => post(
        '/professor/$professorId/turmas/$turmaId/anotacoes',
        {"conteudo": content},
      );

  Future<Response> updateNote(int id, String content) => put(
        '/professor/$professorId/turmas/$turmaId/anotacoes/$id',
        {'conteudo': content},
      );

  Future<Response> deleteNote(int id) => delete(
        '/professor/$professorId/turmas/$turmaId/anotacoes/$id',
      );

  Future<Response> getExams() => get(
        '/professor/$professorId/turmas/$turmaId/avaliacoes',
      );

  Future<Response> addExam(DateTime data, List<Map<String, dynamic>> notas) =>
      post(
        '/professor/$professorId/turmas/$turmaId/avaliacoes',
        {
          "data": DateFormat('dd/MM/yyyy HH:mm:ss').format(data),
          "notas": notas,
        },
      );

  Future<Response> deleteExam(int id) => delete(
        '/professor/$professorId/turmas/$turmaId/avaliacoes/$id',
      );

  Future<Response> deleteClass() => delete(
        '/professor/$professorId/turmas/$turmaId',
      );

  Future<Response> consolidaNotas() => post(
        '/professor/$professorId/turmas/$turmaId/consolidar',
        {},
      );
}

class AttendanceController extends GetxController {
  late final ClassClient classClient;
  final int turmaId;

  final isLoading = false.obs;
  final attendances = <Attendance>[].obs;

  AttendanceController(this.turmaId);

  @override
  void onInit() {
    super.onInit();
    // init
    classClient = Get.put(
      ClassClient(Get.find<GetStorage>().read("id"), turmaId),
    );
    getAttendances();
  }

  void getAttendances() async {
    isLoading(true);
    try {
      final response = await classClient.getAttendances();
      if (response.status.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar as presenças',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final data = response.body as List;
        attendances.assignAll(data.map((e) => Attendance.fromJson(e)).toList());
      }
    } finally {
      isLoading(false);
    }
  }

  Future<List<Aluno>> getStudents() async {
    try {
      final response = await classClient.getStudents();
      if (response.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar os alunos',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        return [];
      } else {
        final data = response.body as List;
        return data.map((e) => Aluno.fromJson(e)).toList();
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> deleteAttendance(List<Attendance> attendances) async {
    final responses = await Future.wait(
      attendances.map(
        (attendance) => classClient.deleteAttendance(attendance.id),
      ),
    );

    final hasError = responses.any((response) => response.hasError);

    if (!hasError) {
      getAttendances();
    }

    return hasError;
  }
}

class NotesController extends GetxController {
  late final ClassClient classClient;
  final int turmaId;

  final isLoading = false.obs;
  final notes = <Note>[].obs;

  NotesController(this.turmaId);

  @override
  void onInit() {
    super.onInit();
    // init
    classClient = Get.put(
      ClassClient(Get.find<GetStorage>().read("id"), turmaId),
    );
    getNotes();
  }

  void getNotes() async {
    isLoading(true);
    try {
      final response = await classClient.getNotes();
      if (response.status.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar as anotações: ${response.body}',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final data = response.body as List;
        final noteList = data.map((e) => Note.fromJson(e)).toList();

        noteList.sort((a, b) => a.data.compareTo(b.data));

        notes.assignAll(noteList);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<Response> addNote(String text) async {
    var res = await classClient.createNote(text);

    if (res.isOk) {
      getNotes();
    }

    return res;
  }

  Future<Response> updateNote(int id, String text) async {
    var res = await classClient.updateNote(id, text);

    if (res.isOk) {
      getNotes();
    }

    return res;
  }

  Future<Response> deleteNote(int id) async {
    var res = await classClient.deleteNote(id);

    if (res.isOk) {
      getNotes();
    }

    return res;
  }
}

class ExamController extends GetxController {
  late final ClassClient classClient;
  final int turmaId;

  final isLoading = false.obs;
  final exams = <Exam>[].obs;

  ExamController(this.turmaId);

  @override
  void onInit() {
    super.onInit();
    // init
    classClient = Get.put(
      ClassClient(Get.find<GetStorage>().read("id"), turmaId),
    );
    getExams();
  }

  void getExams() async {
    isLoading(true);
    try {
      final response = await classClient.getExams();

      if (response.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar as avaliações: ${response.body}',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final data = response.body as List;
        exams.assignAll(data.map((e) => Exam.fromJson(e)).toList());
      }
    } finally {
      isLoading(false);
    }
  }

  Future<Response> addExam(
    DateTime data,
    List<Map<String, dynamic>> notas,
  ) async {
    final response = await classClient.addExam(data, notas);

    if (response.isOk) {
      getExams();
    }

    return response;
  }

  Future<Response> deleteExam(int id) async {
    final response = await classClient.deleteExam(id);

    if (response.isOk) {
      getExams();
    }

    return response;
  }

  Future<Response> consolidarNotas() {
    return classClient.consolidaNotas();
  }
}
