import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T> loading<T>(Future<T> Function() future) async {
  Get.dialog(
    const Dialog(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircularProgressIndicator(),
            Text('Carregando'),
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
