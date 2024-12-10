import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final UserType userType;
  final Function onPressed;
  final String text;

  CustomButton({
    super.key,
    required this.userType,
    required this.onPressed,
    required this.text,
  });

  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: Obx(
              () => AbsorbPointer(
                absorbing: isLoading.value,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final result = onPressed();
                      if (result is Future) {
                        isLoading(true);
                        await result;
                      }
                    } finally {
                      isLoading(false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: userType == UserType.teacher
                        ? HexColor("#4E74F9")
                        : HexColor("#01B6CB"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: (isLoading.value)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          text,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#FFFFFF"),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TeacherButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String text;

  const TeacherButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      userType: UserType.teacher,
      onPressed: onPressed,
      text: text,
    );
  }
}

class StudentButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String text;

  const StudentButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      userType: UserType.student,
      onPressed: onPressed,
      text: text,
    );
  }
}

class CompactButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String text;
  final bool enabled;
  final double height;
  final double fontSize;

  CompactButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.text,
    this.enabled = true,
    this.height = 54,
    this.fontSize = 17,
  });

  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Obx(
        () => AbsorbPointer(
          absorbing: isLoading.value,
          child: ElevatedButton(
            onPressed: enabled
                ? () async {
                    try {
                      final result = onPressed();
                      if (result is Future) {
                        isLoading(true);
                        await result;
                      }
                    } finally {
                      isLoading(false);
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              elevation: 2,
              backgroundColor: color,
              disabledBackgroundColor: color.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: (isLoading.value)
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#FFFFFF"),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}