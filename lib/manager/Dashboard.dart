import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class DashboardPage extends StatelessWidget {
  final int properties = 128;
  final int srs = 54;
  final int units = 348;
  final int owners = 92;

  // Example SR breakdown
  final Map<String, double> srData = const {
    "Open": 20,
    "In Progress": 15,
    "Completed": 14,
    "Closed": 5,
  };

  const DashboardPage({super.key});

  Color _colorForIndex(int i) {
    const palette = [
      Color(0xFF5B8DEF),
      Color(0xFF6AD2C9),
      Color(0xFFF6B25E),
      Color(0xFFB47BEB),
    ];
    return palette[i % palette.length];
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            gradient: _kBrandGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    final dataMap = <String, double>{
      "Properties": properties.toDouble(),
      "SRs": srs.toDouble(),
      "Units": units.toDouble(),
      "Owners": owners.toDouble(),
    };

    final colorList = [
      _colorForIndex(0),
      _colorForIndex(1),
      _colorForIndex(2),
      _colorForIndex(3),
    ];

    final srColorList = const [
      Color(0xFF4A90E2),
      Color(0xFFF6B25E),
      Color(0xFF276221),
      Color(0xFFD0021B),
    ];

    return Container(
      color: const Color(0xFFF5F8FF),
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + kBottomNavigationBarHeight,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: _kBrandGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _kBrandSecondary.withOpacity(0.24),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manager Dashboard',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Monitor properties, requests and services from one place.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.84),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.dashboard_customize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _sectionHeader('Key Metrics', Icons.analytics_outlined),
          const SizedBox(height: 12),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isWide ? 4 : 2,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isWide ? 2.1 : 1.9,
            children: [
              _StatCard(
                title: 'Properties',
                value: properties.toString(),
                icon: Icons.home_work,
                color: _colorForIndex(0),
              ),
              _StatCard(
                title: 'SRs',
                value: srs.toString(),
                icon: Icons.support_agent,
                color: _colorForIndex(1),
              ),
              _StatCard(
                title: 'Units',
                value: units.toString(),
                icon: Icons.apartment,
                color: _colorForIndex(2),
              ),
              _StatCard(
                title: 'Owners',
                value: owners.toString(),
                icon: Icons.person_outline,
                color: _colorForIndex(3),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _sectionHeader('Performance View', Icons.pie_chart_outline_rounded),
          const SizedBox(height: 12),
          _PieChartCard(
            title: 'Overall Distribution',
            dataMap: dataMap,
            colorList: colorList,
            centerText: 'Summary',
          ),
          const SizedBox(height: 14),
          _PieChartCard(
            title: 'Service Requests Status',
            dataMap: srData,
            colorList: srColorList,
            centerText: 'SRs',
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color.withOpacity(0.14),
              ),
              child: Icon(icon, size: 24, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF667A95),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF102A43),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PieChartCard extends StatelessWidget {
  final String title;
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final String centerText;

  const _PieChartCard({
    required this.title,
    required this.dataMap,
    required this.colorList,
    required this.centerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF102A43),
              ),
            ),
            const SizedBox(height: 16),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 34,
              chartRadius: MediaQuery.of(context).size.width / 2.65,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 34,
              centerText: centerText,
              centerTextStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: _kBrandSecondary,
              ),
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendTextStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: const Color(0xFF334E68),
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
                chartValueStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
