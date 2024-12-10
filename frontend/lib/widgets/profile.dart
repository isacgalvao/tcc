import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final Color color;

  Profile(UserType userType, {super.key})
      : color = userType == UserType.student
            ? HexColor("#01B6CB")
            : HexColor("#4E74F9");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 49,
          backgroundColor: color,
          child: ClipOval(
            child: SvgPicture.asset(
              'assets/icons/user.svg',
              height: 72,
              width: 72,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 32,
              maxWidth: 32,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/edit.svg',
                height: 16,
                width: 16,
              ),
              onPressed: () {
                Get.snackbar(
                  "Recurso indisponível",
                  "Em breve...",
                  snackPosition: SnackPosition.TOP,
                  margin: const EdgeInsets.all(16),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TeacherProfile extends StatelessWidget {
  const TeacherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Profile(UserType.teacher);
  }
}

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Profile(UserType.student);
  }
}
