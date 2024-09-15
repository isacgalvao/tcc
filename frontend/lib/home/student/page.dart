import 'package:flutter/material.dart';

class StudentHomePage extends StatelessWidget {
  final String studentName;

  const StudentHomePage({
    super.key,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão Individual de Turmas'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Bem-vindo, estudante!',
            ),
          ],
        ),
      ),
    );
  }
}
