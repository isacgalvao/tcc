import 'package:get/get.dart';

class Backend extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://sistema-escolar-a247d51c11b7.herokuapp.com';
    httpClient.timeout = const Duration(seconds: 60);
  }

  Future<Response> healthcheck() => get('/healthcheck');
}

class RegisterController extends GetxController {
  final client = Get.put(Backend());

  final isLoading = false.obs;

  Future<Response> cadastrar({
    required String nome,
    required String email,
    required String usuario,
    required String senha,
  }) async {
    isLoading.value = true;

    Response res = await client.post('/professores', {
      'nome': nome,
      'email': email,
      'usuario': usuario,
      'senha': senha,
    });

    isLoading.value = false;

    return res;
  }
}
