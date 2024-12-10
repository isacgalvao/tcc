import 'package:frontend/models/attendance.dart';
import 'package:get/get.dart';

class AttendanceClient extends GetConnect {
  final fakeLoadingTime = 2;
  final mock = List.generate(3, (_) => Attendance.random());

  Future<List<Attendance>> fetchAttendance() async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return mock;
  }
}