import 'package:frontend/models/dev.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;

class DevPopupController extends GetxController {
  var isLoading = true.obs;
  var developers = <Dev>[].obs;

  bool get loading => isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchDevelopers();
  }
  

  Future<List<Dev>> getYaml() async {
    final yamlString = await rootBundle.loadString('assets/developers.yaml');
    final yaml = loadYaml(yamlString);

    if (yaml == null || yaml is! YamlList) {
      throw 'Erro ao carregar os desenvolvedores';
    }

    return yaml.map((e) => Dev.fromYaml(e)).toList();
  }

  void fetchDevelopers() async {
    try {
      isLoading(true);
      developers(await getYaml());
    } finally {
      isLoading(false);
    }
  }

  void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }
}

class OnboardingController extends GetxController {
  final isLoading = true.obs;
  final version = '1.0.0'.obs;

  bool get loading => isLoading.value;
  String get appVersion => version.value;

  @override
  void onInit() {
    super.onInit();
    loadVersion();
  }

  void loadVersion() async {
    try {
      isLoading(true);
      version((await PackageInfo.fromPlatform()).version);
    } finally {
      isLoading(false);
    }
  }
}