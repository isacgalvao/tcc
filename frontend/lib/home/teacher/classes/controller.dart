import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/entities.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClassesClient extends GetConnect {
  final int teacherId;

  ClassesClient(this.teacherId);

  @override
  void onInit() {
    httpClient.baseUrl = 'https://sistema-escolar-a247d51c11b7.herokuapp.com';
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response> getClasses() => get('/professor/$teacherId/turmas');
  Future<Response> createClass(Map<String, dynamic> body) => post(
        '/professor/$teacherId/turmas',
        body,
      );
}

class ClassesController extends GetxController {
  final ClassesClient client = Get.put(
    ClassesClient(Get.find<GetStorage>().read('id')),
  );
  final RxList<Turma> turmas = <Turma>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getClasses();
  }

  Future<Response> createClass(
    String nome,
    String disciplina,
    double notaMinima,
    List<int> idsAlunos,
  ) async {
    final body = {
      'nome': nome,
      'disciplina': disciplina,
      'notaMinima': notaMinima,
      'alunos': idsAlunos,
    };
    var res = await client.createClass(body);

    if (res.isOk) {
      getClasses();
    }

    return res;
  }

  Future<void> getClasses() async {
    isLoading(true);
    try {
      final response = await client.getClasses();
      if (response.status.hasError) {
        Get.snackbar(
          'Erro',
          'Erro ao buscar turmas',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        final data = response.body as List;
        turmas.assignAll(data.map((e) => Turma.fromJson(e)).toList());
      }
    } finally {
      isLoading(false);
    }
  }
}
