import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerReportsPage extends StatefulWidget {
  const ManagerReportsPage({super.key});

  @override
  State<ManagerReportsPage> createState() => _ManagerReportsPageState();
}

class _ManagerReportsPageState extends State<ManagerReportsPage> {
  String _searchText = '';
  String _selectedFilter = 'All';

  final List<Map<String, String>> _reports = const [
    {
      'name': 'Property List Report',
      'type': 'Property',
      'date': 'Jan 15, 2024',
      'by': 'John Doe',
      'size': '2.5 MB',
      'status': 'Ready',
    },
    {
      'name': 'Service Requests Summary',
      'type': 'Service Request',
      'date': 'Jan 14, 2024',
      'by': 'Jane Smith',
      'size': '1.8 MB',
      'status': 'Ready',
    },
    {
      'name': 'User Activity Report',
      'type': 'User',
      'date': 'Jan 13, 2024',
      'by': 'Admin User',
      'size': '950 KB',
      'status': 'Ready',
    },
    {
      'name': 'Monthly Analytics',
      'type': 'Analytics',
      'date': 'Jan 12, 2024',
      'by': 'System',
      'size': '3.2 MB',
      'status': 'Processing',
    },
    {
      'name': 'Unit Occupancy Report',
      'type': 'Unit',
      'date': 'Jan 11, 2024',
      'by': 'Property Manager',
      'size': '1.5 MB',
      'status': 'Ready',
    },
    {
      'name': 'Failed Report Test',
      'type': 'Test',
      'date': 'Jan 10, 2024',
      'by': 'Test User',
      'size': 'N/A',
      'status': 'Failed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const filters = [
      'All',
      'Property',
      'Service Request',
      'User',
      'Analytics',
      'Unit',
      'Ready',
      'Processing',
      'Failed',
    ];

    final filtered =
        _reports.where((report) {
          final q = _searchText.trim().toLowerCase();
          final matchesSearch =
              q.isEmpty ||
              report['name']!.toLowerCase().contains(q) ||
              report['type']!.toLowerCase().contains(q) ||
              report['by']!.toLowerCase().contains(q) ||
              report['status']!.toLowerCase().contains(q);
          final matchesFilter =
              _selectedFilter == 'All' ||
              report['type'] == _selectedFilter ||
              report['status'] == _selectedFilter;
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
                      'Reports',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'View and generate property reports',
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
                child: const Icon(Icons.summarize_rounded, color: Colors.white),
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
              hintText: 'Search by report name, type, generator or status',
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
              'No reports match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ...filtered.map((report) => _ReportItemCard(report: report)),
        const SizedBox(height: 16),
      ],
    );
  }

  IconData _filterIcon(String filter) {
    switch (filter) {
      case 'Property':
        return Icons.domain_rounded;
      case 'Service Request':
        return Icons.assignment_rounded;
      case 'User':
        return Icons.person_rounded;
      case 'Analytics':
        return Icons.analytics_rounded;
      case 'Unit':
        return Icons.apartment_rounded;
      case 'Ready':
        return Icons.check_circle_rounded;
      case 'Processing':
        return Icons.autorenew_rounded;
      case 'Failed':
        return Icons.error_rounded;
      default:
        return Icons.layers_rounded;
    }
  }
}

class _ReportItemCard extends StatelessWidget {
  const _ReportItemCard({required this.report});

  final Map<String, String> report;

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(report['status'] ?? 'Ready');

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
                    Icons.summarize_rounded,
                    color: Color(0xFF243B53),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report['name'] ?? '-',
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
                          _QuickTag(text: report['type'] ?? '-'),
                          _QuickTag(text: report['status'] ?? '-'),
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
                    icon: Icons.calendar_today_rounded,
                    label: 'Generated',
                    value: report['date'] ?? '-',
                  ),
                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'By',
                    value: report['by'] ?? '-',
                  ),
                  _DetailRow(
                    icon: Icons.storage_rounded,
                    label: 'File Size',
                    value: report['size'] ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(label: report['status'] ?? '-', color: statusColor),
                const Spacer(),
                _IconActionButton(
                  icon: Icons.visibility_outlined,
                  color: const Color(0xFF10B981),
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _IconActionButton(
                  icon: Icons.download_rounded,
                  color: const Color(0xFF2563EB),
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _IconActionButton(
                  icon: Icons.delete_rounded,
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

  Color _statusColor(String status) {
    switch (status) {
      case 'Ready':
        return const Color(0xFF65A30D);
      case 'Processing':
        return const Color(0xFF2563EB);
      case 'Failed':
        return const Color(0xFFDC2626);
      default:
        return _kBrandPrimary;
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

class _QuickTag extends StatelessWidget {
  const _QuickTag({required this.text});

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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
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
