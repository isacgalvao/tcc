import 'package:flutter/material.dart';

class HomeTeacher extends StatelessWidget {
  final String teacherName;

  const HomeTeacher({super.key, this.teacherName = 'Professor'});

  String saudacao() {
    final now = DateTime.now();
    final hour = now.hour;
    print("Data e hora: $now");
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                "${saudacao()}, $teacherName",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
