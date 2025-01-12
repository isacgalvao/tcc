import 'package:flutter/material.dart';
import 'package:frontend/pages/onboarding_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/pages/student_home_page.dart';
import 'package:frontend/pages/teacher_home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gestão de Turmas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: StudentHomePage(),
    );
  }
}
