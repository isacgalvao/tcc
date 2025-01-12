import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class GradesChart extends StatelessWidget {
  final barData = [
    LineChartBarData(
      color: HexColor("#01B6CB"),
      spots: [
        FlSpot(1, 5),
        FlSpot(2, 6),
        FlSpot(3, 3),
      ],
      isCurved: false,
      isStrokeCapRound: true,
      barWidth: 1,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: HexColor("#01B6CB"),
          );
        },
      ),
    ),
    LineChartBarData(
      color: HexColor("#FFA800"),
      spots: [
        FlSpot(1, 4),
        FlSpot(2, 5),
        FlSpot(3, 6),
      ],
      isCurved: false,
      isStrokeCapRound: true,
      barWidth: 1,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: HexColor("#FFA800"),
          );
        },
      ),
    ),
    LineChartBarData(
      color: HexColor("#FF5C5C"),
      spots: [
        FlSpot(1, 7),
        FlSpot(2, 8),
        FlSpot(3, 9),
      ],
      isCurved: false,
      isStrokeCapRound: true,
      barWidth: 1,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1,
            strokeColor: HexColor("#FF5C5C"),
          );
        },
      ),
    ),
  ];

  GradesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        right: 24,
        bottom: 8,
        left: 8,
      ),
      constraints: BoxConstraints(
        maxWidth: 382,
        maxHeight: 166,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.white,
                    tooltipBorder: BorderSide(
                      color: HexColor("#01B6CB"),
                      width: 1,
                    ),
                  ),
                ),
                lineBarsData: barData,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      "Notas",
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: HexColor("#000000").withOpacity(0.7),
                      ),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            meta.formattedValue,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: HexColor("#000000").withOpacity(0.7),
                            ),
                          ),
                        );
                      },
                      // reservedSize: 32,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      interval: 1,
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            "${meta.formattedValue}ª av.",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: HexColor("#000000").withOpacity(0.7),
                            ),
                          ),
                        );
                      },
                      // reservedSize: 32,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: HexColor("#00001A").withOpacity(0.15),
                      strokeWidth: 0.5,
                      dashArray: [3, 3],
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: HexColor("#00001A").withOpacity(0.15),
                      strokeWidth: 0.5,
                      dashArray: [3, 3],
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: HexColor("#00001A").withOpacity(0.15),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLegend(
                color: HexColor("#01B6CB"),
                label: "Matemática",
              ),
              _buildLegend(
                color: HexColor("#FFA800"),
                label: "Português",
              ),
              _buildLegend(
                color: HexColor("#FF5C5C"),
                label: "História",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend({
    required Color color,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: HexColor("#000000").withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
