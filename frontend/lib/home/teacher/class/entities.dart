import 'package:frontend/home/teacher/classes/entities.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}

class ExamValue {
  final int id;
  final int value;
  final Aluno student;
  final Exam exam;

  ExamValue({
    required this.id,
    required this.value,
    required this.student,
    required this.exam,
  });
}

class Exam {
  final int id;
  final String title;
  final List<ExamValue> values;

  Exam({
    required this.id,
    required this.title,
    required this.values,
  });

  Exam.empty()
      : id = 0,
        title = '',
        values = [];
}
