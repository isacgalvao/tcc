import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddAttendanceController extends GetxController {
  final initialDate = DateTime.now();
  final firstDate = DateTime(DateTime.now().year, 1, 1);
  final lastDate = DateTime(DateTime.now().year, 12, 31);

  // observables
  late final Rx<DateTime> _selectedDate;

  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate(value);

  // entities
  final students = List.generate(10, (_) => Student.random());

  @override
  void onInit() {
    _selectedDate = initialDate.obs;
    super.onInit();
  }

  get formattedDate => DateFormat('dd/MM/yyyy').format(selectedDate);

  bool isToday() {
    final today = DateTime.now();
    return selectedDate.day == today.day &&
        selectedDate.month == today.month &&
        selectedDate.year == today.year;
  }

  Future<void> saveAttendance() async {
    await Future.delayed(Duration(seconds: 2));
    Get.back();
    successSnackbar(
      'Presença salva',
      'Presença salva com sucesso!',
    );
  }
}
