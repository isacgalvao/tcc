import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginClient extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://sistema-escolar-a247d51c11b7.herokuapp.com';
  }

  Future<Response> loginUser(String usuario, String senha) => post(
        "/auth/login",
        {
          'user': usuario,
          'password': senha,
        },
      );

  Future<Response> loginEmail(String email, String senha) => post(
        "/auth/login",
        {
          'email': email,
          'password': senha,
        },
      );
}

class LoginController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isChecked = false.obs;
  bool get isChecked => _isChecked.value;
  set checked(bool value) => _isChecked.value = value;
  notChecked() => _isChecked.value = !_isChecked.value;

  final LoginClient _client = Get.put(LoginClient());
  final GetStorage _storage = Get.find();

  Future<dynamic> auth(String userOrEmail, String password) async {
    _isLoading.value = true;
    try {
      final res = GetUtils.isEmail(userOrEmail)
          ? await _client.loginEmail(userOrEmail, password)
          : await _client.loginUser(userOrEmail, password);

      if (!res.isOk) {
        return null;
      }

      _storage.write('id', res.body['id']);
      if (isChecked) {
        _storage.write('nome', res.body['nome']);
        _storage.write('role', res.body['role']);
      }

      return res.body;
    } finally {
      _isLoading.value = false;
    }
  }
}
