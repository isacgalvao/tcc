import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T> loading<T>(
  Future<T> Function() future, {
  String title = "Carregando...",
}) async {
  Get.dialog(
    Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircularProgressIndicator(),
            Text(title),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  try {
    return await future();
  } finally {
    Get.back();
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
