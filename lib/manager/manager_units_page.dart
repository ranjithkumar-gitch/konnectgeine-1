import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view_unit_details_page.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerUnitsPage extends StatefulWidget {
  const ManagerUnitsPage({super.key});

  @override
  State<ManagerUnitsPage> createState() => _ManagerUnitsPageState();
}

class _ManagerUnitsPageState extends State<ManagerUnitsPage> {
  String _selectedFilter = 'All';
  String _searchText = '';

  final List<Map<String, dynamic>> _units = const [
    {
      'id': 'U20265',
      'property': 'Stephenson House',
      'propertyType': 'Apartments/Condo',
      'unitNo': 'S-409',
      'tenant': 'No tenant',
      'occupancy': 'Under Construction',
      'status': 'Active',
      'category': 'Construction',
    },
    {
      'id': 'U20264',
      'property': 'Stephenson House',
      'propertyType': 'Apartments/Condo',
      'unitNo': 'S-509',
      'tenant': 'No tenant',
      'occupancy': 'Vacant for Rent',
      'status': 'Active',
      'category': 'Vacant',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const filters = ['All', 'Active', 'Vacant', 'Construction'];

    final filtered =
        _units.where((unit) {
          final search = _searchText.trim().toLowerCase();
          final matchesSearch =
              search.isEmpty ||
              unit['id'].toString().toLowerCase().contains(search) ||
              unit['property'].toString().toLowerCase().contains(search) ||
              unit['unitNo'].toString().toLowerCase().contains(search) ||
              unit['occupancy'].toString().toLowerCase().contains(search);

          final matchesFilter =
              _selectedFilter == 'All' ||
              unit['category'] == _selectedFilter ||
              unit['status'] == _selectedFilter;

          return matchesSearch && matchesFilter;
        }).toList();

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
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
                      'Units',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage all property units with premium controls',
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
                child: const Icon(Icons.apartment_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by unit ID, property, occupancy or unit number',
              hintStyle: GoogleFonts.poppins(fontSize: 13),
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children:
              filters
                  .map(
                    (filter) => _FilterPill(
                      icon: _filterIcon(filter),
                      label: filter,
                      isActive: _selectedFilter == filter,
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 18),
        if (filtered.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'No units match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ...filtered.map(
            (unit) => _UnitItemCard(
              unit: unit,
              onView: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ViewUnitDetailsPage(unit: unit),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  IconData _filterIcon(String filter) {
    switch (filter) {
      case 'Active':
        return Icons.verified_rounded;
      case 'Vacant':
        return Icons.meeting_room_rounded;
      case 'Construction':
        return Icons.construction_rounded;
      default:
        return Icons.layers_rounded;
    }
  }
}

class _UnitItemCard extends StatelessWidget {
  const _UnitItemCard({required this.unit, required this.onView});

  final Map<String, dynamic> unit;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    final occupancyColor = _occupancyColor(unit['occupancy'] as String);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                        unit['property'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _UnitQuickTag(text: 'ID ${unit['id']}'),
                          _UnitQuickTag(text: 'Unit ${unit['unitNo']}'),
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
                  _UnitDetailRow(
                    icon: Icons.home_work_outlined,
                    label: 'Property Type',
                    value: unit['propertyType'] as String,
                  ),
                  _UnitDetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Tenant',
                    value: unit['tenant'] as String,
                  ),
                  _UnitDetailRow(
                    icon: Icons.event_seat_outlined,
                    label: 'Occupancy',
                    value: unit['occupancy'] as String,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(
                  label: unit['status'] as String,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                _StatusChip(
                  label: unit['occupancy'] as String,
                  color: occupancyColor,
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: onView,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blueGrey.shade100),
                    foregroundColor: const Color(0xFF243B53),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: Text('View', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _occupancyColor(String value) {
    switch (value) {
      case 'Vacant for Rent':
        return const Color(0xFF9333EA);
      case 'Under Construction':
        return const Color(0xFFD18B00);
      default:
        return const Color(0xFF3567E0);
    }
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fgColor = isActive ? Colors.white : _kBrandSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: isActive ? _kBrandGradient : null,
          color: isActive ? null : Colors.white,
          border: Border.all(
            color: isActive ? Colors.transparent : const Color(0xFFD9E2EC),
          ),
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: _kBrandPrimary.withOpacity(0.22),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: fgColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: fgColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitQuickTag extends StatelessWidget {
  const _UnitQuickTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF486581),
        ),
      ),
    );
  }
}

class _UnitDetailRow extends StatelessWidget {
  const _UnitDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF627D98)),
          const SizedBox(width: 10),
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF7B8794),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF243B53),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
