import 'package:flutter/material.dart';
import 'package:frontend/clients/class_client.dart';
import 'package:frontend/clients/student_client.dart';
import 'package:frontend/models/class.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:get/get.dart';

class TeacherHomeController extends GetxController {
  // Initial page index
  static const initialPage = 2;

  final _selectedIndex = initialPage.obs;
  final pageController = PageController(initialPage: initialPage);

  get selectedIndex => _selectedIndex.value;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}

// TODO: melhorar a injecção de dependências
class HomeController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Entities
  final recentClasses = <Class>[].obs;

  // Clients
  final client = Get.put(ClassClient());

  @override
  void onInit() {
    super.onInit();
    getRecentClasses();
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  // String getName() {
  //   return Get.find<AuthController>().user.value.name;
  // }

  String getName() {
    return '{name}';
  }

  // TODO: implementar o método getRecentClasses
  void getRecentClasses({String? query}) async {
    try {
      _isLoading(true);
      recentClasses(await client.getClasses(query));
    } finally {
      _isLoading(false);
    }
  }
}

class ClassesController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Controllers
  final searchController = TextEditingController();

  // Clients
  final client = Get.put(ClassClient());

  // Entities
  final classes = <Class>[].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    onSearch();
  }

  // TODO: deve haver um método para buscar as classes no banco de dados e outro para buscar as classes em memória
  Future<void> fetchClasses() async {
    try {
      _isLoading(true);
      await client.fetchClasses();
      onSearch(query: searchController.text);
    } finally {
      _isLoading(false);
    }
  }

  void onSearch({String? query}) async {
    await client.getClasses(query).then((value) => classes(value));
  }

  void clear() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      onSearch();
    }
  }
}

class StudentsController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Controllers
  final searchController = TextEditingController();

  // Clients
  final client = Get.put(StudentManagementClient());

  // Entities
  final students = <Student>[].obs;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    onSearch();
  }

  Future<void> fetchStudents() async {
    try {
      _isLoading(true);
      await client.fetchStudents();
      onSearch(query: searchController.text);
    } finally {
      _isLoading(false);
    }
  }

  void onSearch({String? query}) async {
    await client.getStudents(query).then((value) => students(value));
  }

  void clear() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
      onSearch();
    }
  }
}

class ProfileController extends GetxController {
  // Observables
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  // Controllers
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // TODO: implementar
  String getName() {
    return '{name}';
  }

  String getEmail() {
    return 'email@example.com';
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 2));
      successSnackbar('Sucesso', 'Perfil atualizado com sucesso');
    }
  }

  String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!GetUtils.isEmail(value)) {
      return 'E-mail inválido';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 6) {
      return 'Senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }
}
