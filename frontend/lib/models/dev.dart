import 'package:yaml/yaml.dart';

class Dev {
  final String name;
  final String imageUrl;
  final String profileUrl;

  Dev({required this.name, required this.imageUrl, required this.profileUrl});

  factory Dev.fromYaml(YamlMap yamlMap) {
    return Dev(
      name: yamlMap['name'],
      imageUrl: yamlMap['imageUrl'],
      profileUrl: yamlMap['profileUrl'],
    );
  }
}