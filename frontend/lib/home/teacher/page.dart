import 'package:flutter/material.dart';
import 'package:frontend/home/teacher/classes/page.dart';
import 'package:get/get.dart';

class TeacherHomePage extends StatelessWidget {
  final String teacherName;

  const TeacherHomePage({super.key, this.teacherName = 'professor'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                "Olá, $teacherName",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomCard(
                icon: Icons.local_convenience_store_sharp,
                title: 'Minhas turmas',
                onTap: () => Get.to(() => ClassesPage()),
              ),
              CustomCard(
                icon: Icons.emoji_people_rounded,
                title: 'Meus alunos',
                onTap: () => {},
              ),
              CustomCard(
                icon: Icons.person,
                title: 'Meu perfil',
                onTap: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          color: Theme.of(context).colorScheme.primaryFixed,
          elevation: 4,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 64,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
