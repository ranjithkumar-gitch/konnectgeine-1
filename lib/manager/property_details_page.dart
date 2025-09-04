import 'package:flutter/material.dart';
import './_expandable_unit_card.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const PropertyDetailsPage({Key? key, required this.property})
    : super(key: key);

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final units = _buildUnits(widget.property);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property['name'] ?? 'Property Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.apartment,
                            color: Colors.blue,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Property Details',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1.2),
                  Row(
                    children: [
                      const Icon(Icons.home, color: Colors.indigo, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.property['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.property['address'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(
                        Icons.meeting_room,
                        color: Colors.teal,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Units: ${widget.property['units']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(
                        Icons.group,
                        color: Colors.deepPurple,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Group: ${widget.property['group']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Units',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 10),
          ...units.map((unit) => ExpandableUnitCard(unit: unit)),
        ],
      ),
    );
  }
}

List<Map<String, String>> _buildUnits(Map<String, dynamic> property) {
  final int unitCount = int.tryParse(property['units'].toString()) ?? 0;
  final List<String> tenantNames = [
    'Amit Sharma',
    'Priya Singh',
    'Rahul Verma',
    'Sneha Patel',
    'Vikram Rao',
    'Anjali Mehta',
    'Rohan Das',
    'Neha Gupta',
    'Siddharth Jain',
    'Pooja Nair',
    'Karan Kapoor',
    'Divya Iyer',
    'Manish Joshi',
    'Swati Agarwal',
    'Arjun Menon',
    'Meera Pillai',
    'Suresh Reddy',
    'Ritu Chawla',
    'Deepak Sinha',
    'Shalini Roy',
  ];
  return List.generate(unitCount, (i) {
    final unitNum = (i + 1).toString().padLeft(3, '0');
    return {
      'unitNumber': 'U$unitNum',
      'floor': ((i ~/ 4) + 1).toString(),
      'tenant': tenantNames[i % tenantNames.length],
      'phone': '+91 90000${(10000 + i).toString().padLeft(5, '0')}',
    };
  });
}
