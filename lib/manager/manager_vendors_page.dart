import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerVendorsPage extends StatefulWidget {
  const ManagerVendorsPage({super.key});

  @override
  State<ManagerVendorsPage> createState() => _ManagerVendorsPageState();
}

class _ManagerVendorsPageState extends State<ManagerVendorsPage> {
  String _searchText = '';
  String _selectedFilter = 'All';

  final List<Map<String, String>> _vendors = const [
    {
      'name': 'David Thompson',
      'email': 'david.thompson@yahoo.com',
      'service': 'General',
      'code': '2026003',
      'city': 'Madison Heights',
      'linkedOn': 'Mar 31, 2026',
      'status': 'Active',
      'initials': 'DT',
    },
    {
      'name': 'Sarah Mills',
      'email': 'sarah.mills@vendor.com',
      'service': 'Cleaning',
      'code': '2026004',
      'city': 'Detroit',
      'linkedOn': 'Mar 18, 2026',
      'status': 'Active',
      'initials': 'SM',
    },
    {
      'name': 'North Build Co',
      'email': 'ops@northbuild.com',
      'service': 'Maintenance',
      'code': '2026005',
      'city': 'Troy',
      'linkedOn': 'Feb 27, 2026',
      'status': 'Inactive',
      'initials': 'NB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const filters = [
      'All',
      'Active',
      'Inactive',
      'General',
      'Cleaning',
      'Maintenance',
    ];

    final filtered =
        _vendors.where((vendor) {
          final query = _searchText.trim().toLowerCase();
          final matchesSearch =
              query.isEmpty ||
              vendor['name']!.toLowerCase().contains(query) ||
              vendor['email']!.toLowerCase().contains(query) ||
              vendor['code']!.toLowerCase().contains(query) ||
              vendor['city']!.toLowerCase().contains(query) ||
              vendor['service']!.toLowerCase().contains(query);
          final matchesFilter =
              _selectedFilter == 'All' ||
              vendor['status'] == _selectedFilter ||
              vendor['service'] == _selectedFilter;
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
                      'My Vendors',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage linked vendors with premium controls',
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
                child: const Icon(
                  Icons.storefront_rounded,
                  color: Colors.white,
                ),
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
            onChanged: (value) => setState(() => _searchText = value),
            decoration: InputDecoration(
              hintText: 'Search by vendor name, email, service, code or city',
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
                      onTap: () => setState(() => _selectedFilter = filter),
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
              'No vendors match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ...filtered.map((vendor) => _VendorItemCard(vendor: vendor)),
        const SizedBox(height: 16),
      ],
    );
  }

  IconData _filterIcon(String filter) {
    switch (filter) {
      case 'Active':
        return Icons.verified_rounded;
      case 'Inactive':
        return Icons.block_rounded;
      case 'General':
        return Icons.build_circle_outlined;
      case 'Cleaning':
        return Icons.cleaning_services_rounded;
      case 'Maintenance':
        return Icons.handyman_rounded;
      default:
        return Icons.layers_rounded;
    }
  }
}

class _VendorItemCard extends StatelessWidget {
  const _VendorItemCard({required this.vendor});

  final Map<String, String> vendor;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        vendor['status'] == 'Active' ? Colors.green : const Color(0xFFDC2626);

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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF3E8FF), Color(0xFFE9D5FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    vendor['initials'] ?? 'VD',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF7C3AED),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor['name'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF102A43),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _VendorQuickTag(text: 'Code ${vendor['code']}'),
                          _VendorQuickTag(text: vendor['service'] ?? '-'),
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
                  _VendorDetailRow(
                    icon: Icons.mail_outline_rounded,
                    label: 'Email',
                    value: vendor['email'] ?? '-',
                  ),
                  _VendorDetailRow(
                    icon: Icons.location_city_rounded,
                    label: 'City',
                    value: vendor['city'] ?? '-',
                  ),
                  _VendorDetailRow(
                    icon: Icons.calendar_today_rounded,
                    label: 'Linked On',
                    value: vendor['linkedOn'] ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(label: vendor['status'] ?? '-', color: statusColor),
                const Spacer(),
                _IconActionButton(
                  icon: Icons.visibility_outlined,
                  color: const Color(0xFF10B981),
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _IconActionButton(
                  icon: Icons.link_off_rounded,
                  color: const Color(0xFFEF4444),
                  onTap: () {},
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

class _VendorQuickTag extends StatelessWidget {
  const _VendorQuickTag({required this.text});

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

class _VendorDetailRow extends StatelessWidget {
  const _VendorDetailRow({
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
            width: 80,
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

class _IconActionButton extends StatelessWidget {
  const _IconActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
