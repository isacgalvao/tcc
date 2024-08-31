class Aluno {
  final int id;
  final String nome;
  final List<Turma> turmas;

  const Aluno({
    required this.id,
    required this.nome,
    required this.turmas,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Aluno && other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ turmas.hashCode;
}

class Turma {
  final String nome;
  final String disciplina;
  final int quantidadeAlunos;
  List<Aluno> alunos = [];

  Turma({
    required this.nome,
    required this.disciplina,
    required this.quantidadeAlunos,
  });

  Turma.empty()
      : nome = '',
        disciplina = '',
        quantidadeAlunos = 0;
}
