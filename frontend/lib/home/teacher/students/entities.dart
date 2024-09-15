import 'package:intl/intl.dart';

class Aluno {
  final int id;
  final String nome;
  final String email;
  final String? usuario;
  final String telefone;
  final DateTime dataNascimento;
  final String situacao;

  Aluno({
    required this.id,
    required this.nome,
    required this.email,
    required this.usuario,
    required this.telefone,
    required this.dataNascimento,
    required this.situacao,
  });

  factory Aluno.random() {
    return Aluno(
      id: 0,
      nome: 'Fulano de Tal',
      email: 'fulano@mail.com',
      usuario: 'fulano',
      telefone: '(00) 00000-0000',
      dataNascimento: DateTime.now(),
      situacao: 'Ativo',
    );
  }

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      usuario: json['usuario'],
      telefone: json['telefone'],
      dataNascimento: DateFormat('yyyy-MM-dd').parse(json['dataNascimento']),
      situacao: json['situacao'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Aluno && other.id == id;
  }
}
