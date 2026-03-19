import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ExpandableUnitCard extends StatefulWidget {
  final Map<String, String> unit;
  const ExpandableUnitCard({super.key, required this.unit});

  @override
  State<ExpandableUnitCard> createState() => _ExpandableUnitCardState();
}

class _ExpandableUnitCardState extends State<ExpandableUnitCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final unitNumber = widget.unit['unitNumber'] ?? '-';
    final floor = widget.unit['floor'] ?? '-';
    final tenant = widget.unit['tenant'] ?? '-';
    final phone = widget.unit['phone'] ?? '-';

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),

      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFFD9E2EC), Color(0xFFBCCCDC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.meeting_room_outlined,
              color: Color(0xFF243B53),
            ),
          ),
          title: Text(
            'Unit $unitNumber',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF102A43),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              children: [
                Text(
                  'Floor $floor',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF627D98),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    gradient: _kBrandGradient,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Occupied',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: AnimatedRotation(
            duration: const Duration(milliseconds: 220),
            turns: _expanded ? 0.5 : 0,
            child: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
          onExpansionChanged: (val) => setState(() => _expanded = val),
          collapsedBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _UnitDetailRow(
                    icon: Icons.person_outline,
                    label: 'Tenant',
                    value: tenant,
                  ),
                  _UnitDetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: phone,
                  ),
                  _UnitDetailRow(
                    icon: Icons.apartment_outlined,
                    label: 'Floor',
                    value: floor,
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

class _UnitDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _UnitDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey[400]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kBrandSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
