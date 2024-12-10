import 'package:frontend/clients/student_client.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

class AddExamController extends GetxController {
  
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  final client = Get.put(StudentClient());
  
  final students = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }
  
  void fetchStudents() async {
    try {
      _isLoading(true);
      final students = await client.fetchStudents();
      this.students.assignAll(students);
    } finally {
      _isLoading(false);
    }
  }

  Future<void> addExam() async {
    await Future.delayed(Duration(seconds: 2));
    Get.back();
    successSnackbar("Sucesso", "Avaliação adicionada com sucesso");
  }
}