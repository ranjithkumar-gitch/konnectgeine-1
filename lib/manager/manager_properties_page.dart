import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'property_details_page.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerPropertiesPage extends StatefulWidget {
  const ManagerPropertiesPage({super.key});

  @override
  State<ManagerPropertiesPage> createState() => _ManagerPropertiesPageState();
}

class _ManagerPropertiesPageState extends State<ManagerPropertiesPage> {
  String _selectedGroup = 'All';
  String _searchText = '';
  final List<Map<String, dynamic>> _properties = [
    {
      'id': 'P1001',
      'name': 'Sunshine Apartments',
      'address': '123 Main St, Downtown',
      'units': 40,
      'group': 'Alpha Group',
    },
    {
      'id': 'P1002',
      'name': 'Green Meadows',
      'address': '456 Park Ave, Midtown',
      'units': 32,
      'group': 'Beta Group',
    },
    {
      'id': 'P1003',
      'name': 'Blue Skies Residency',
      'address': '789 Lake Rd, Uptown',
      'units': 28,
      'group': 'Gamma Group',
    },
    {
      'id': 'P1004',
      'name': 'Palm Grove',
      'address': '321 Palm St, Suburbia',
      'units': 50,
      'group': 'Delta Group',
    },
    {
      'id': 'P1005',
      'name': 'Lakeview Towers',
      'address': '654 River Rd, Midtown',
      'units': 36,
      'group': 'Alpha Group',
    },
    {
      'id': 'P1006',
      'name': 'Maple Residency',
      'address': '987 Maple Ave, Downtown',
      'units': 22,
      'group': 'Beta Group',
    },
    {
      'id': 'P1007',
      'name': 'Orchid Enclave',
      'address': '159 Orchid St, Uptown',
      'units': 44,
      'group': 'Gamma Group',
    },
    {
      'id': 'P1008',
      'name': 'Cedar Heights',
      'address': '753 Cedar Rd, Suburbia',
      'units': 30,
      'group': 'Delta Group',
    },
    {
      'id': 'P1009',
      'name': 'Emerald Greens',
      'address': '852 Emerald Blvd, Midtown',
      'units': 38,
      'group': 'Alpha Group',
    },
    {
      'id': 'P1010',
      'name': 'Royal Residency',
      'address': '951 Royal St, Downtown',
      'units': 27,
      'group': 'Beta Group',
    },
    {
      'id': 'P1011',
      'name': 'Skyline Towers',
      'address': '357 Skyline Ave, Uptown',
      'units': 41,
      'group': 'Gamma Group',
    },
    {
      'id': 'P1012',
      'name': 'Willow Woods',
      'address': '258 Willow Rd, Suburbia',
      'units': 35,
      'group': 'Delta Group',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final groupNames =
        _properties.map((e) => e['group'] as String).toSet().toList();
    final allGroupNames = <String>['All', ...groupNames];
    final filtered =
        _properties.where((e) {
          final matchesGroup =
              _selectedGroup == 'All' || _selectedGroup == e['group'];
          final search = _searchText.trim().toLowerCase();
          final matchesSearch =
              search.isEmpty ||
              e['name'].toString().toLowerCase().contains(search) ||
              e['address'].toString().toLowerCase().contains(search) ||
              e['id'].toString().toLowerCase().contains(search);
          return matchesGroup && matchesSearch;
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
                      'Properties',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage all assigned properties with premium controls',
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
              hintText: 'Search by property name, address or ID',
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
              allGroupNames
                  .map(
                    (group) => _FilterPill(
                      icon:
                          group == 'All'
                              ? Icons.layers_rounded
                              : Icons.group_work_outlined,
                      label: group,
                      isActive: _selectedGroup == group,
                      onTap: () {
                        setState(() {
                          _selectedGroup = group;
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
              'No properties match your search/filter.',
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
            (prop) => _PropertyItemCard(
              property: prop,
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PropertyDetailsPage(property: prop),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _PropertyItemCard extends StatelessWidget {
  final Map<String, dynamic> property;
  final VoidCallback onView;

  const _PropertyItemCard({required this.property, required this.onView});

  @override
  Widget build(BuildContext context) {
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
                        property['name'] as String,
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
                          _PropertyQuickTag(text: 'ID ${property['id']}'),
                          _PropertyQuickTag(text: property['group'] as String),
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
                  _PropertyDetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: property['address'] as String,
                  ),
                  _PropertyDetailRow(
                    icon: Icons.apartment_rounded,
                    label: 'Units',
                    value: '${property['units']}',
                  ),
                  _PropertyDetailRow(
                    icon: Icons.group_outlined,
                    label: 'Owner Group',
                    value: property['group'] as String,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(
                  label: (property['units'] as int) > 30 ? 'Active' : 'Limited',
                  color:
                      (property['units'] as int) > 30
                          ? Colors.green
                          : Colors.orange,
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
}

class _FilterPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _FilterPill({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = isActive ? Colors.white : _kBrandSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          gradient: isActive ? _kBrandGradient : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? _kBrandSecondary : Colors.blueGrey.shade100,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: fgColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyQuickTag extends StatelessWidget {
  final String text;

  const _PropertyQuickTag({required this.text});

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

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.22)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _PropertyDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _PropertyDetailRow({
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
