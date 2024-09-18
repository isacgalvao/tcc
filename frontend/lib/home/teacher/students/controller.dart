import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentsClient extends GetConnect {
  final int professorId;

  StudentsClient(this.professorId);

  @override
  void onInit() {
    httpClient.baseUrl = 'https://sistema-escolar-a247d51c11b7.herokuapp.com';
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response> getStudents() => get('/professores/$professorId');

  Future<Response> createStudent(Map<String, dynamic> body) => post(
        '/alunos',
        body,
      );

  Future<Response> deleteStudent(int id) => delete('/alunos/$id');

  Future<Response> searchStudents(String query) => get(
        '/professores/$professorId/alunos?nome=$query',
      );

  Future<Response> createAccess(int id, String usuario, String senha) => put(
        '/alunos/$id',
        {'usuario': usuario, 'senha': senha},
      );
}

class StudentsController extends GetxController {
  final isLoading = false.obs;
  final StudentsClient _studentsClient = Get.put(
    StudentsClient(Get.find<GetStorage>().read('id')),
  );
  final RxList<Aluno> alunos = <Aluno>[].obs;

  StudentsController();

  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  Future<Response> createStudent(
    String nome,
    String email,
    String telefone,
    String dataNascimento,
  ) async {
    final response = await _studentsClient.createStudent({
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
      'professorId': Get.find<GetStorage>().read('id'),
    });

    if (response.isOk) {
      getStudents();
    }

    return response;
  }

  void getStudents() async {
    try {
      isLoading(true);

      final response = await _studentsClient.getStudents();
      if (response.status.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar alunos',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final data = response.body['alunos'] as List;
        alunos.assignAll(data.map((e) => Aluno.fromJson(e)).toList());
      }
    } finally {
      isLoading(false);
    }
  }

  Future<Response> deleteStudent(int id) async {
    var res = await _studentsClient.deleteStudent(id);

    if (res.isOk) {
      getStudents();
    }

    return res;
  }

  Future<List<Aluno>> searchAlunos(String query) async {
    var res = await _studentsClient.searchStudents(query);

    if (res.isOk) {
      final data = List.from(res.body);
      return data.map((e) => Aluno.fromJson(e)).toList();
    }

    Get.snackbar(
      'Erro',
      'Erro ao buscar alunos',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    return [];
  }

  Future<Response> criarAcesso(
    int id,
    String usuario, {
    String senha = "123456",
  }) async {
    return _studentsClient.createAccess(id, usuario, senha);
  }

  Future<Response> revogarAcesso(int id) {
    return _studentsClient.createAccess(id, '', '');
  }
}
