import 'dart:math';

import 'package:frontend/models/student.dart';

class Attendance {
  final DateTime date;
  final List<Student> attendees;

  Attendance({
    required this.date,
    required this.attendees,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      date: DateTime.parse(json['date']),
      attendees: (json['attendees'] as List)
          .map((e) => Student.fromJson(e))
          .toList(),
    );
  }

  factory Attendance.random() {
    final random = Random();
    return Attendance(
      date: DateTime.now().subtract(Duration(days: random.nextInt(10))),
      attendees: List.generate(
        random.nextInt(30),
        (index) => Student.random(),
      ),
    );
  }
}