import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './_expandable_unit_card.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const PropertyDetailsPage({super.key, required this.property});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final units = _buildUnits(widget.property);
    final String propertyName = widget.property['name']?.toString() ?? '';
    final String propertyAddress = widget.property['address']?.toString() ?? '';
    final String propertyId = widget.property['id']?.toString() ?? 'N/A';
    final String group = widget.property['group']?.toString() ?? 'N/A';
    final String unitCount = widget.property['units']?.toString() ?? '0';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          propertyName.isEmpty ? 'Property Details' : propertyName,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: _kBrandGradient,
              boxShadow: [
                BoxShadow(
                  color: _kBrandSecondary.withOpacity(0.22),
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
                        'Property Details',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'View full property profile and associated units',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          height: 1.3,
                          color: Colors.white.withOpacity(0.82),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.domain_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD9E2EC), Color(0xFFBCCCDC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.apartment_rounded,
                          color: Color(0xFF243B53),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              propertyName,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF102A43),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _QuickTag(text: 'ID $propertyId'),
                                _QuickTag(text: 'Group $group'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _DetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: propertyAddress,
                        ),
                        _DetailRow(
                          icon: Icons.meeting_room_outlined,
                          label: 'Units',
                          value: unitCount,
                        ),
                        _DetailRow(
                          icon: Icons.group_outlined,
                          label: 'Owner Group',
                          value: group,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: _kBrandGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.apartment_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Units',
                style: GoogleFonts.poppins(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF102A43),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _kBrandPrimary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _kBrandPrimary.withOpacity(0.2)),
                ),
                child: Text(
                  '$unitCount total',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _kBrandSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (units.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                'No units are available for this property.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            ...units.map((unit) => ExpandableUnitCard(unit: unit)),
        ],
      ),
    );
  }
}

class _QuickTag extends StatelessWidget {
  final String text;

  const _QuickTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kBrandPrimary.withOpacity(0.18)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: _kBrandSecondary,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey[400]),
          const SizedBox(width: 8),
          SizedBox(
            width: 88,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kBrandSecondary,
              ),
            ),
          ),
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
