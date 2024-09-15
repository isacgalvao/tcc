import 'package:frontend/home/teacher/students/entities.dart';

class Turma {
  final int id;
  final String nome;
  final String disciplina;
  final List<Aluno> alunos;
  final Map<String, double>? resultadosFinais;
  final double notaMinima;
  final String situacao;
  final DateTime dataCriacao;

  Turma({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.alunos,
    required this.resultadosFinais,
    required this.notaMinima,
    required this.situacao,
    required this.dataCriacao,
  });

  factory Turma.empty() {
    return Turma(
      id: -1,
      nome: '',
      disciplina: '',
      alunos: [],
      resultadosFinais: {},
      notaMinima: 0,
      situacao: '',
      dataCriacao: DateTime.now(),
    );
  }

  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      id: json['id'],
      nome: json['nome'],
      disciplina: json['disciplina'],
      alunos: List<Aluno>.from(json['alunos'].map((e) => Aluno.fromJson(e))),
      resultadosFinais: Map<String, double>.from(json['resultadosFinais']),
      notaMinima: json['notaMinima'],
      situacao: json['situacao'],
      dataCriacao: DateTime.parse(json['dataCriacao']),
    );
  }
}
