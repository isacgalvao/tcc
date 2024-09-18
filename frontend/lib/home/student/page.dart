import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/home/student/controller.dart';
import 'package:frontend/role/page.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentHomePage extends StatelessWidget {
  final String studentName;

  StudentHomePage({super.key, required this.studentName});

  final _controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller.pageController,
          onPageChanged: _controller.onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Home(studentName: studentName),
            const Turmas(),
            Perfil(studentName: studentName),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: _controller.selectedIndex.value,
              onTap: _controller.onItemTapped,
              type: BottomNavigationBarType.shifting,
              selectedItemColor: HexColor.fromHex("#01B6CB"),
              unselectedItemColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                      _controller.selectedIndex.value == 0
                          ? HexColor.fromHex("#01B6CB")
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/turmas.svg',
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                      _controller.selectedIndex.value == 1
                          ? HexColor.fromHex("#01B6CB")
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Turmas',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/profile.svg',
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                      _controller.selectedIndex.value == 2
                          ? HexColor.fromHex("#01B6CB")
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final double size;

  const CustomCard({super.key, required this.child, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}

class Chart extends StatelessWidget {
  final Widget child;

  const Chart({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }
}

class Home extends StatelessWidget {
  final String studentName;

  const Home({super.key, required this.studentName});

  LineTouchData lineTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
      ),
      handleBuiltInTouches: true,
    );
  }

  // Dados para o gráfico
  List<FlSpot> getSpots() {
    return const [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 2),
      FlSpot(3, 5),
      FlSpot(4, 3),
      FlSpot(5, 4),
    ];
  }

  LineChartData getLineChartData() {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: getSpots(),
          isCurved: true,
          color: Colors.blue,
          barWidth: 4,
          belowBarData: BarAreaData(show: false),
        ),
      ],
      titlesData: const FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
      ),
      borderData: FlBorderData(show: true),
      gridData: const FlGridData(show: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#01B6CB'),
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage('assets/circle.png'),
                  alignment: Alignment.topLeft,
                  fit: BoxFit.contain,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Olá, $studentName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  "Meus resultados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                TextButton(
                  child: const Text("Ver notas"),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 2,
              child: Chart(child: LineChart(getLineChartData())),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(
                  size: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "7,5",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Média do ano",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "2024",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                CustomCard(
                  size: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Número de faltas",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "2024",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(
                  size: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "2,0",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Menor nota do ano",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "2024",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                CustomCard(
                  size: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "9,0",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Maior nota do ano",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "2024",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Turmas extends StatelessWidget {
  const Turmas({super.key});

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  "Turma $index",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Álgebra",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '15 alunos',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black.withOpacity(0.5),
                      size: 16,
                    )
                  ],
                ),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: getRandomColor(),
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Perfil extends StatelessWidget {
  final String studentName;

  Perfil({super.key, required this.studentName});

  final _controller = Get.put(PerfilController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: HexColor.fromHex("#01B6CB"),
            child: const Icon(
              Icons.person_rounded,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            studentName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Turmas: 5",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 64),
          Obx(
            () => TextFormField(
              controller: _controller.passwordController,
              obscureText: _controller.obscureText.value,
              decoration: InputDecoration(
                labelText: 'Senha',
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: HexColor.fromHex("#6C7072"),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _controller.obscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: HexColor.fromHex("#6C7072"),
                  ),
                  onPressed: _controller.toggleObscureText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor.fromHex("#01B6CB"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Alterar senha",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () async {
              final canExit = await Get.dialog(
                AlertDialog(
                  title: const Text("Sair"),
                  content: const Text("Deseja realmente sair?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: const Text("Sair"),
                    ),
                  ],
                ),
              );

              if (canExit) {
                final storage = Get.find<GetStorage>();
                storage.remove('nome');
                storage.remove('user');
                storage.remove('role');
                storage.remove('id');

                Get.offAll(() => const RolePage());
              }
            },
            child: const Text(
              "Sair",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
