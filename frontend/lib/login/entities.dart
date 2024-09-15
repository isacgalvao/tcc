enum Role {
  aluno("Aluno"),
  professor("Professor");

  final String description;

  const Role(this.description);

  String getRoleDescription() {
    return description;
  }

  static Role fromString(String role) {
    if (role.toLowerCase() == "aluno") {
      return Role.aluno;
    } else {
      return Role.professor;
    }
  }
}

class User {
  Role role;

  User({required this.role});
}
