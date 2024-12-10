import 'dart:math';

import 'package:uuid/uuid.dart';

enum Status {
  active,
  inactive;

  static Status parse(String status) {
    return status == 'active' ? Status.active : Status.inactive;
  }

  String get name {
    switch (this) {
      case Status.active:
        return 'Ativo';
      case Status.inactive:
        return 'Inativo';
    }
  }
}

class Student {
  final String id;
  final String name;
  final Status status;
  final String color;

  Student({
    required this.id,
    required this.name,
    required this.status,
    required this.color,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      status: Status.parse(json['status']),
      color: json['color'],
    );
  }

  factory Student.random() {
    final random = Random.secure();
    return Student(
        id: const Uuid().v4(),
        name: 'Student ${random.nextInt(100)}',
        status: random.nextBool() ? Status.active : Status.inactive,
        color: '#4E74F9');
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student && other.id == id;
  }
}
