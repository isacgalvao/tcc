import 'package:frontend/models/class.dart';
import 'package:get/get.dart';

// TODO: implement ClassClient
class ClassClient extends GetConnect {
  final fakeLoadingTime = 2;
  final mock = [
    Class(
      id: "b12c9dd3-a431-4532-90f1-5e4cc58320a4",
      name: 'Turma 01',
      subject: 'Matemática',
      color: 'FF0000',
      students: [
        'João',
        'Maria',
        'José',
        'Ana',
        'Carlos',
      ],
    ),
    Class(
      id: "62f43606-0e78-4c35-b662-e0d6551d566a",
      name: 'Turma 02',
      subject: 'Português',
      color: '00FF00',
      students: [
        'Antônio',
        'Júlia',
        'Pedro',
      ],
    ),
    Class(
      id: "dfba907a-9a68-4de2-b909-45be8e222c17",
      name: 'Turma 03',
      subject: 'História',
      color: '0000FF',
      students: [
        'Mariana',
        'Fernando',
        'Luísa',
        'Rafael',
      ],
    ),
  ];

  Future<List<Class>> getClasses(String? query) async {
    if (query == null || query.isEmpty) {
      return mock;
    } else {
      return mock
          .where((c) =>
              c.name.isCaseInsensitiveContains(query) ||
              c.subject.isCaseInsensitiveContains(query))
          .toList();
    }
  }

  Future<List<Class>> fetchClasses() async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return mock;
  }

  Future<bool> enableNotifications(String classId) async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return true;
  }

  Future<bool> disableNotifications(String classId) async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return true;
  }
}
