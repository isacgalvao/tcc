import 'dart:math';

import 'package:uuid/uuid.dart';

class ExamStudent {
  final String studentId;
  final String examId;
  final double score;

  ExamStudent({
    required this.studentId,
    required this.examId,
    required this.score,
  });

  factory ExamStudent.fromJson(Map<String, dynamic> json) {
    return ExamStudent(
      studentId: json['studentId'],
      examId: json['examId'],
      score: json['score'],
    );
  }

  factory ExamStudent.random() {
    final random = Random();
    return ExamStudent(
      studentId: const Uuid().v4(),
      examId: const Uuid().v4(),
      score: random.nextDouble() * 100,
    );
  }
}

class Exam {
  final String title;
  final List<ExamStudent> studentExams;
  final DateTime date;

  Exam({
    required this.title,
    required this.studentExams,
    required this.date,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      title: json['title'],
      studentExams: (json['studentExams'] as List)
          .map((studentExam) => ExamStudent.fromJson(studentExam))
          .toList(),
      date: DateTime.parse(json['date']),
    );
  }

  factory Exam.random() {
    final random = Random();
    return Exam(
      title: 'Exam ${random.nextInt(100)}',
      studentExams: List.generate(
        random.nextInt(10),
        (_) => ExamStudent.random(),
      ),
      date: DateTime.now().subtract(Duration(days: random.nextInt(365))),
    );
  }
}
