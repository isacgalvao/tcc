import 'package:frontend/home/teacher/students/entities.dart';

class Attendance {
  final int id;
  final DateTime data;
  final Aluno aluno;
  String? justificativa;

  Attendance({
    required this.id,
    required this.data,
    required this.aluno,
    this.justificativa,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      data: DateTime.parse(json['data']),
      aluno: Aluno.fromJson(json['aluno']),
      justificativa: json['justificativa'],
    );
  }

  Attendance.of({
    required this.aluno,
    required this.data,
    this.justificativa,
  }) : id = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendance && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Note {
  final int id;
  final DateTime data;
  final String conteudo;

  Note({
    required this.id,
    required this.data,
    required this.conteudo,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      data: DateTime.parse(json['data']),
      conteudo: json['conteudo'],
    );
  }
}

class ExamValue {
  final int id;
  final double valor;
  final Aluno aluno;

  ExamValue({
    required this.id,
    required this.valor,
    required this.aluno,
  });

  factory ExamValue.fromJson(Map<String, dynamic> json) {
    return ExamValue(
      id: json['id'],
      valor: json['valor'],
      aluno: Aluno.fromJson(json['aluno']),
    );
  }
}

class Exam {
  final int id;
  final DateTime data;
  final List<ExamValue> notas;

  Exam({
    required this.id,
    required this.data,
    required this.notas,
  });

  Exam.empty()
      : id = 0,
        data = DateTime.now(),
        notas = [];

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      data: DateTime.parse(json['data']),
      notas: List<ExamValue>.from(
        json['notas'].map((e) => ExamValue.fromJson(e)),
      ),
    );
  }
}
