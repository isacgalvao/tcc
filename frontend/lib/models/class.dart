import 'dart:math';

import 'package:uuid/uuid.dart';

class Class {
  final String id;
  final String name;
  final String subject;
  final String color;
  final List<dynamic> students;
  final DateTime createdAt;

  Class({
    required this.id,
    required this.name,
    required this.subject,
    required this.color,
    required this.students,
  }) : createdAt = DateTime.now();

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      color: json['color'],
      students: json['students'],
    );
  }

  factory Class.random() {
    final rand = Random.secure();
    final subjects = [
      'Matemática',
      'Português',
      'História',
      'Geografia',
      'Física',
      'Química',
      'Biologia',
      'Inglês',
      'Espanhol',
      'Artes',
      'Educação Física',
      'Filosofia',
      'Sociologia',
    ];
    return Class(
      id: const Uuid().v4(),
      name: 'Turma ${rand.nextInt(100)}',
      subject: subjects[rand.nextInt(subjects.length)],
      color: '#4E74F9',
      students: List.filled(rand.nextInt(20), "Fulano"),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subject': subject,
        'color': color,
        'students': students,
      };
}
