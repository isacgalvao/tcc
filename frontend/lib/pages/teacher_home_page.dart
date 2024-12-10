import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/controllers/teacher_home_controller.dart';
import 'package:frontend/models/class.dart';
import 'package:frontend/models/student.dart';
import 'package:frontend/pages/create_class_page.dart';
import 'package:frontend/pages/register_student_page.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/card.dart';
import 'package:frontend/widgets/profile.dart';
import 'package:frontend/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherHomePage extends StatelessWidget {
  TeacherHomePage({super.key});

  final controller = Get.put(TeacherHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ClassesPage(),
                StudentsPage(),
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          // TODO: procurar icones melhores para os itens
          child: SalomonBottomBar(
            onTap: controller.onItemTapped,
            currentIndex: controller.selectedIndex,
            selectedItemColor: HexColor("#4E74F9"),
            // unselectedItemColor: HexColor("#A1A1A1"),
            items: [
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/icons/teacher_home/classes.svg",
                  colorFilter: ColorFilter.mode(
                    HexColor("#4E74F9"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/teacher_home/classes.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  "Turmas",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/icons/teacher_home/students.svg",
                  colorFilter: ColorFilter.mode(
                    HexColor("#4E74F9"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/teacher_home/students.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  "Alunos",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/icons/teacher_home/home.svg",
                  colorFilter: ColorFilter.mode(
                    HexColor("#4E74F9"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/teacher_home/home.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  "Início",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: Image.asset(
                  "assets/icons/teacher_home/reports.png",
                  color: HexColor("#4E74F9"),
                  width: 24,
                  height: 24,
                ),
                icon: Image.asset(
                  "assets/icons/teacher_home/reports.png",
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  "Relatórios",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SalomonBottomBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/icons/teacher_home/profile.svg",
                  colorFilter: ColorFilter.mode(
                    HexColor("#4E74F9"),
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                icon: SvgPicture.asset(
                  "assets/icons/teacher_home/profile.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
                title: Text(
                  "Perfil",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassesPage extends StatelessWidget {
  ClassesPage({super.key});

  final controller = Get.put(ClassesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: HexColor("#F5F5F5"),
            borderRadius: BorderRadius.circular(16),
          ),
          // TODO: melhorar essa barra de pesquisa
          child: TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              hintText: "Buscar turma",
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: HexColor("#A1A1A1"),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  "assets/icons/teacher_home/search.svg",
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    HexColor("#A1A1A1"),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: HexColor("#A1A1A1"),
                ),
                onPressed: () => controller.clear(),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: HexColor("#F5F5F5"),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20,
              ),
            ),
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            onSubmitted: (query) => controller.onSearch(query: query),
            onChanged: (query) => controller.onSearch(query: query),
          ),
        ),
        titleSpacing: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateClassPage()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(54),
        ),
        backgroundColor: HexColor("#4E74F9"),
        foregroundColor: Colors.white,
        tooltip: "Adicionar turma",
        child: const Icon(Icons.add_rounded),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchClasses,
        child: Obx(
          () {
            final classes = controller.isLoading
                ? List.filled(controller.classes.length, Class.random())
                : controller.classes;
            final child = classes.isNotEmpty
                ? ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      return ClassCard(classes[index]);
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.class_outlined,
                          size: 64,
                          color: HexColor("#A1A1A1"),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Nenhuma turma encontrada",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: HexColor("#A1A1A1"),
                          ),
                        ),
                      ],
                    ),
                  );
            return Skeletonizer(enabled: controller.isLoading, child: child);
          },
        ),
      ),
    );
  }
}

class StudentsPage extends StatelessWidget {
  StudentsPage({super.key});

  final controller = Get.put(StudentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: HexColor("#F5F5F5"),
            borderRadius: BorderRadius.circular(16),
          ),
          // TODO: melhorar essa barra de pesquisa
          child: TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              hintText: "Buscar aluno",
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: HexColor("#A1A1A1"),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  "assets/icons/teacher_home/search.svg",
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    HexColor("#A1A1A1"),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: HexColor("#A1A1A1"),
                ),
                onPressed: () => controller.clear(),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: HexColor("#F5F5F5"),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20,
              ),
            ),
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            onSubmitted: (query) => controller.onSearch(query: query),
            onChanged: (query) => controller.onSearch(query: query),
          ),
        ),
        titleSpacing: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => RegisterStudentPage()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(54),
        ),
        backgroundColor: HexColor("#4E74F9"),
        foregroundColor: Colors.white,
        tooltip: "Adicionar aluno",
        child: const Icon(Icons.person_add_rounded),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchStudents,
        child: Obx(
          () {
            final students = controller.isLoading
                ? List.filled(controller.students.length, Student.random())
                : controller.students;
            final child = students.isNotEmpty
                ? ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return StudentCard(students[index]);
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 64,
                          color: HexColor("#A1A1A1"),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Nenhum aluno encontrado",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: HexColor("#A1A1A1"),
                          ),
                        ),
                      ],
                    ),
                  );
            return Skeletonizer(enabled: controller.isLoading, child: child);
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildCard(),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              "Turmas recentes",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.find<TeacherHomeController>().onItemTapped(0);
              },
              child: Text(
                "Ver todas",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#4E74F9"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Obx(() {
          final classes = controller.isLoading
              ? List.filled(7, Class.random())
              : controller.recentClasses;
          return Expanded(
            child: Skeletonizer(
              enabled: controller.isLoading,
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return ClassCard(classes[index]);
                },
              ),
            ),
          );
        })
      ],
    );
  }

  IntrinsicHeight _buildCard() {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 240,
        ),
        decoration: BoxDecoration(
          color: HexColor("#4E74F9"),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                "assets/icons/teacher_home/container_bg.svg",
                width: 200,
                height: 200,
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
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: card(
                          "Turmas",
                          "5",
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: card(
                          "Alunos",
                          "100",
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: card(
                          "Aulas",
                          "5",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IntrinsicWidth card(String title, String value) {
    return IntrinsicWidth(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 80,
          minHeight: 80,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: HexColor("#4E74F9"),
              ),
            ),
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: HexColor("#4E74F9"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 116),
        Icon(
          Icons.analytics_outlined,
          size: 64,
          color: HexColor("#A1A1A1"),
        ),
        const SizedBox(height: 16),
        Text(
          "Em breve...",
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: HexColor("#A1A1A1"),
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            const SizedBox(height: 116),
            const TeacherProfile(),
            const SizedBox(height: 32),
            Text(
              controller.getName(),
              style: GoogleFonts.dmSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.getEmail(),
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: HexColor("#6F6F79"),
              ),
            ),
            const SizedBox(height: 42),
            UserFormField(
              controller: controller.userController,
              validator: controller.validateUser,
            ),
            const SizedBox(height: 22),
            EmailFormField(
              controller: controller.emailController,
              validator: controller.validateEmail,
            ),
            const SizedBox(height: 22),
            PasswordFormField(
              controller: controller.passwordController,
              validator: controller.validatePassword,
              initialObscureText: false,
              hintText: "Nova senha",
            ),
            const SizedBox(height: 38),
            TeacherButton(
              text: "Atualizar Dados",
              onPressed: controller.updateProfile,
            )
          ],
        ),
      ),
    );
  }
}
