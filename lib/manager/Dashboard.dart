import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Stat cards
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 14,
              mainAxisSpacing: 12,
              childAspectRatio: 2.6,
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

            const SizedBox(height: 20),

            // Overall Summary Pie Chart
            // _PieChartCard(
            //   title: 'Overall Distribution',
            //   dataMap: dataMap,
            //   colorList: colorList,
            //   centerText: 'Summary',
            // ),
            const SizedBox(height: 20),

            // Service Requests Pie Chart
            _PieChartCard(
              title: 'Service Requests Status',
              dataMap: srData,
              colorList: srColorList,
              centerText: 'SRs',
            ),
          ],
        ),
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color.withOpacity(0.15),
              ),
              child: Icon(icon, size: 26, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert, color: Colors.black26),
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 40,
              chartRadius: MediaQuery.of(context).size.width / 2.8,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 36,
              centerText: centerText,
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
