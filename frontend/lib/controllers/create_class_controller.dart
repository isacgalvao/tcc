import 'package:flutter/material.dart';
import 'package:frontend/clients/class_client.dart';
import 'package:frontend/clients/student_client.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

class CreateClassController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Controllers
  final classNameController = TextEditingController();
  final subjectController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Clients
  final client = Get.put(ClassClient());

  // Entities
  final students = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  String? validateClassName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome da turma é obrigatório';
    }
    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'A disciplina é obrigatória';
    }
    return null;
  }

  // TODO: Implement createClass
  Future<void> createClass() async {
    if (students.isEmpty) {
      failSnackbar('Erro', 'Adicione pelo menos um aluno a turma');
      return;
    }

    if (formKey.currentState!.validate()) {
      try {
        _isLoading(true);
        await Future.delayed(const Duration(seconds: 2));
        // await client.createClass(
        //   name: nameController.text,
        //   subject: subjectController.text,
        //   students: students,
        // );
        Get.back();
        successSnackbar('Sucesso', 'Turma criada com sucesso');
      } finally {
        _isLoading(false);
      }
    }
  }

  void removeStudent(int index) {
    students.removeAt(index);
  }
}

class SearchStudentController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Clients
  final client = Get.put(StudentClient());

  // Entities
  final students = <Student>[].obs;
  final selectedStudents = <Student>[].obs;

  set selectedStudents(List<Student> students) {
    selectedStudents.assignAll(students);
  }

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }
  
  void fetchStudents() async {
    try {
      _isLoading(true);
      students.assignAll(await client.fetchStudents());
    } finally {
      _isLoading(false);
    }
  }

  Future<void> searchStudents(String query) async {
    try {
      _isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      students.assignAll(await client.getStudents(query));
    } finally {
      _isLoading(false);
    }
  }
}
