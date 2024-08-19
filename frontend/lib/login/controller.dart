import 'package:frontend/login/entities.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isChecked = false.obs;
  bool get isChecked => _isChecked.value;
  set checked(bool value) => _isChecked.value = value;
  notChecked() => _isChecked.value = !_isChecked.value;

  Future<User?> auth(String email, String password) async {
    _isLoading.value = true;
    print("Fake login $email....");
    await Future.delayed(const Duration(seconds: 1));
    _isLoading.value = false;

    return User(role: Role.teacher);
  }
}
