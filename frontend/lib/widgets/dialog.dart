import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BlurredDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final Color confirmColor;

  const BlurredDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: HexColor('#4E74F9'),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              confirmText,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: confirmColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurredDialog2 extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final Color confirmColor;

  const BlurredDialog2({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Container(
          constraints: BoxConstraints(
            minHeight: 100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#6C7072"),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Esta ação não poderá ser desfeita.",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ).animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              ).fade(
                end: 1,
                begin: 0.5,
                duration: const Duration(milliseconds: 500),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HexColor('#6C7072'),
              ),
            ),
          ),
          CompactButton(
            onPressed: () => Get.back(result: true),
            color: HexColor('#4E74F9'),
            fontSize: 14,
            height: 44,
            text: confirmText,
          ),
        ],
      ),
    );
  }
}

class FormDialog extends StatelessWidget {
  final String title;
  final String confirmText;
  final Color confirmColor;

  FormDialog({
    super.key,
    required this.title,
    required this.confirmText,
    required this.confirmColor,
  });

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Form(
          key: _formKey,
          child: UserFormField(
            controller: _controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: null),
            child: Text('Cancelar',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: HexColor('#4E74F9'),
                )),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Get.back(result: _controller.text);
              }
            },
            child: Text(
              confirmText,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: confirmColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextDialog extends StatelessWidget {
  final String title;
  final String confirmText;
  final Color confirmColor;

  TextDialog({
    super.key,
    required this.title,
    required this.confirmText,
    required this.confirmColor,
  });

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: 'Digite aqui...',
            hintStyle: GoogleFonts.poppins(
              fontSize: 13,
              color: HexColor('#6F6F79'),
            ),
          ),
          minLines: 6,
          maxLines: null,
        ),
        actions: [
          TeacherButton(
            onPressed: () async => Get.back(result: _controller.text),
            text: confirmText,
          ),
        ],
      ),
    );
  }
}

Future<bool> confirmDialog({
  required String title,
  required String content,
  required String confirmText,
  Color confirmColor = const Color(0xFF4E74F9),
}) async {
  return await Get.dialog(
        BlurredDialog(
          title: title,
          content: content,
          confirmText: confirmText,
          confirmColor: confirmColor,
        ),
        barrierColor: Colors.black.withOpacity(0.1),
      ) ??
      false;
}

Future<bool> confirmDialog2({
  required String title,
  required String content,
  required String confirmText,
  Color confirmColor = const Color(0xFF4E74F9),
}) async {
  return await Get.dialog(
        BlurredDialog2(
          title: title,
          content: content,
          confirmText: confirmText,
          confirmColor: confirmColor,
        ),
        barrierColor: Colors.black.withOpacity(0.1),
      ) ??
      false;
}

Future<String?> formDialog({
  required String title,
  required String confirmText,
  Color confirmColor = const Color(0xFF4E74F9),
}) async {
  return await Get.dialog(
    FormDialog(
      title: title,
      confirmText: confirmText,
      confirmColor: confirmColor,
    ),
    barrierColor: Colors.black.withOpacity(0.1),
  );
}

Future<String?> textDialog({
  required String title,
  required String confirmText,
  Color confirmColor = const Color(0xFF4E74F9),
}) async {
  return await Get.dialog(
    TextDialog(
      title: title,
      confirmText: confirmText,
      confirmColor: confirmColor,
    ),
    barrierColor: Colors.black.withOpacity(0.1),
  );
}
