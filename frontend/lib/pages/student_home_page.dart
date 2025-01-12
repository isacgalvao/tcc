import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/student_home_controller.dart';
import 'package:frontend/models/class.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/card.dart';
import 'package:frontend/widgets/chart.dart';
import 'package:frontend/widgets/profile.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class StudentHomePage extends StatelessWidget {
  StudentHomePage({super.key});

  final controller = Get.put(StudentHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ClassesPage(),
                AttendancePage(),
                HomePage(),
                ReportsPage(),
                ProfilePage(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SalomonBottomBar(
            selectedItemColor: HexColor("#01B6CB"),
            items: [
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/student_home/classes.svg',
                  colorFilter: ColorFilter.mode(
                    HexColor("#01B6CB"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/student_home/classes.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  'Turmas',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.qr_code_rounded,
                  size: 26,
                ),
                title: Text(
                  'Frequência',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/student_home/home.svg',
                  colorFilter: ColorFilter.mode(
                    HexColor("#01B6CB"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/student_home/home.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  'Home',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: Image.asset(
                  'assets/icons/student_home/reports.png',
                  color: HexColor("#01B6CB"),
                  width: 24,
                  height: 24,
                ),
                icon: Image.asset(
                  'assets/icons/student_home/reports.png',
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  'Relatórios',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/student_home/profile.svg',
                  colorFilter: ColorFilter.mode(
                    HexColor("#01B6CB"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/student_home/profile.svg',
                  colorFilter: ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  'Perfil',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            currentIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
          ),
        ),
      ),
    );
  }
}

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: 16,
        children: List.generate(67, (index) {
          return StudentClassCard(Class.random());
        }),
      ),
    );
  }
}

class _CornerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Cor da borda
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    double length = 30; // Tamanho da borda nos cantos

    // Canto superior esquerdo
    canvas.drawLine(Offset(0, 0), Offset(length, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, length), paint);

    // Canto superior direito
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - length, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, length),
      paint,
    );

    // Canto inferior esquerdo
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - length), paint);
    canvas.drawLine(
      Offset(0, size.height),
      Offset(length, size.height),
      paint,
    );

    // Canto inferior direito
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - length, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CornerBorderContainer extends StatelessWidget {
  final Widget child;

  const CornerBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CustomPaint(
        painter: _CornerBorderPainter(),
        child: child,
      ),
    );
  }
}

class AttendancePage extends StatelessWidget {
  AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Frequência",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 16,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: MobileScanner(
              overlayBuilder: (context, constraints) => Center(
                child: CornerBorderContainer(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
              onDetect: (barcodes) => successSnackbar("Deu certo kk",
                  barcodes.barcodes.first.displayValue ?? "nullkkk"),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCard(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Meus resultados",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Imprimir",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#01B6CB"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        GradesChart(),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricCard(
              title: "Média geral",
              subtitle: "2024",
              value: 7.5,
            ),
            _buildMetricCard(
              title: "Número de faltas",
              subtitle: "2024",
              value: 12,
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricCard(
              title: "Meno nota do ano",
              subtitle: "2024",
              value: 2.0,
            ),
            _buildMetricCard(
              title: "Maior nota do ano",
              subtitle: "2024",
              value: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#01B6CB"),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              "assets/icons/teacher_home/container_bg.svg",
              width: 118,
              height: 118,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Olá, ${controller.getName()}",
                          style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          controller.greeting(),
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 56,
                        minHeight: 56,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String subtitle,
    required dynamic value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxWidth: 160,
        maxHeight: 160,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              _formatNumber(value),
              style: GoogleFonts.dmSans(
                fontSize: 52,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.dmSans(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#727272"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _formatNumber(dynamic number) {
    if (number is double) {
      return NumberFormat("#,##0.0#", "pt_BR").format(number);
    }
    return number.toString();
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StudentReportCard(
            title: "Frequência por aluno",
            page: Scaffold(
              appBar: AppBar(
                title: Text("Frequência por aluno"),
              ),
              body: Center(
                child: Text("Frequência por aluno"),
              ),
            ),
          ),
          const SizedBox(height: 16),
          StudentReportCard(
            title: "Notas por aluno",
            page: Scaffold(
              appBar: AppBar(
                title: Text("Notas por aluno"),
              ),
              body: Center(
                child: Text("Notas por aluno"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StudentProfile(),
              const SizedBox(height: 24),
              Text(
                "{nome}",
                style: GoogleFonts.dmSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Turmas: {qtde_turmas}",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: HexColor("#6F6F79"),
                ),
              ),
              const SizedBox(height: 38),
              PasswordFormField(
                controller: TextEditingController(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 38),
              StudentButton(
                text: "Alterar senha",
                onPressed: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  successSnackbar(
                      "Senha alterada com sucesso", "Senha alterada");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
