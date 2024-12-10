import 'package:frontend/models/student.dart';
import 'package:get/get.dart';

// TODO: implement StudentClient
class StudentClient extends GetConnect {
  final fakeLoadingTime = 2;
  final mock = [
    Student(
      id: "b12c9dd3-a431-4532-90f1-5e4cc58320a4",
      name: 'Ana',
      status: Status.active,
      color: 'FF0000',
    ),
    Student(
      id: "a12c9dd3-a431-4532-90f1-5e4cc58320a4",
      name: 'João',
      status: Status.active,
      color: '00FF00',
    ),
    Student(
      id: "c12c9dd3-a431-4532-90f1-5e4cc58320a4",
      name: 'Maria',
      status: Status.active,
      color: '0000FF',
    ),
  ];

  Future<List<Student>> getStudents(String? query) async {
    if (query == null || query.isEmpty) {
      return mock;
    } else {
      return mock
          .where((c) => c.name.isCaseInsensitiveContains(query))
          .toList();
    }
  }

  Future<List<Student>> fetchStudents() async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return mock;
  }
}
