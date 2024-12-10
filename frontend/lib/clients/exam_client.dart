import 'package:frontend/models/exam.dart';
import 'package:get/get.dart';

class ExamClient extends GetConnect {
  final fakeLoadingTime = 2;
  final mock = List.generate(3, (_) => Exam.random());

  Future<List<Exam>> fetchExams() async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return mock;
  }
}