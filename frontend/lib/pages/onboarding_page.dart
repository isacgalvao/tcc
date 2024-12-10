import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/onboarding_controller.dart';
import 'package:frontend/models/dev.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/skeleton.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset(
                'assets/images/onboarding2.svg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
            Positioned(
              left: 142,
              top: 10,
              child: SvgPicture.asset(
                'assets/images/onboarding3.svg',
                fit: BoxFit.cover,
                width: 33,
                height: 31,
              ),
            ),
            Positioned(
              right: 0,
              top: 27,
              child: SvgPicture.asset(
                'assets/images/onboarding4.svg',
                fit: BoxFit.cover,
                width: 116,
                height: 110,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onLongPress: () => Get.dialog(DevPopup()),
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Versão ',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#6F6F79"),
                          ),
                        ),
                        Skeletonizer(
                          enabled: controller.loading,
                          child: Text(
                            controller.appVersion,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: HexColor("#6F6F79"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Olá\nVamos começar?',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 27),
                    Text(
                      'Primeiro nos diga qual seu papel na instituição',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: HexColor("#6F6F79"),
                      ),
                    ),
                    const SizedBox(height: 82),
                    SvgPicture.asset(
                      'assets/images/onboarding1.svg',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 82),
                    OnboardingButton(
                      color: HexColor("#4E74F9"),
                      text: 'Sou professor(a)',
                      onPressed: () => Get.to(
                        () => LoginPage(UserType.teacher),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OnboardingButton(
                      color: HexColor("#01B6CB"),
                      text: 'Sou aluno(a) ou responsável',
                      onPressed: () => Get.to(
                        () => LoginPage(UserType.student),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingButton extends StatelessWidget {
  final Color? color;
  final String text;
  final VoidCallback? onPressed;

  const OnboardingButton(
      {super.key, required this.color, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        minimumSize: const Size(double.infinity, 50),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class DevPopup extends StatelessWidget {
  final DevPopupController controller = Get.put(DevPopupController());

  DevPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Desenvolvedores',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Obx(() {
          if (controller.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 8,
            children: controller.developers.map(developerWidget).toList(),
          );
        }),
      ),
    );
  }

  Widget developerWidget(Dev dev) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.launchUrl(dev.profileUrl),
          child: AvatarSkeleton(dev.imageUrl),
        ),
        const SizedBox(height: 8),
        Text(dev.name),
      ],
    );
  }
}
