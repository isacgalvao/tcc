import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/home/student/page.dart';
import 'package:frontend/home/teacher/page.dart';
import 'package:frontend/login/entities.dart';
import 'package:frontend/role/page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const Main());
}

Widget get() {
  final storage = Get.put(GetStorage(), permanent: true);
  final String? role = storage.read('role');
  final String? nome = storage.read('nome');

  if (role == null || nome == null) {
    return const RolePage();
  }

  if (Role.fromString(role) == Role.aluno) {
    return StudentHomePage(studentName: nome);
  } else if (Role.fromString(role) == Role.professor) {
    return TeacherHomePage(teacherName: nome);
  } else {
    return const RolePage();
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gestão Individual de Turmas',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: get(),
    );
  }
}
