import 'package:flutter/material.dart';
import 'view_user_details_page.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerUsersPage extends StatefulWidget {
  const ManagerUsersPage({super.key});

  @override
  State<ManagerUsersPage> createState() => _ManagerUsersPageState();
}

class _ManagerUsersPageState extends State<ManagerUsersPage> {
  String _searchText = '';
  String _selectedFilter = 'All';

  final List<Map<String, String>> _users = const [
    {
      'name': 'Emily Carter',
      'email': 'emily.carter@yahoo.com',
      'role': 'Owner',
      'phone': '5866007448',
      'status': 'Active',
      'initials': 'EC',
      'category': 'Owner',
      'country': 'United States',
      'state': 'Michigan',
      'city': 'Madison Heights',
      'zip': '48071',
      'street': '',
      'notes': '',
    },
    {
      'name': 'Kerry Grushoff',
      'email': 'kerry.grushoff@konnect.com',
      'role': 'Manager',
      'phone': '5866007449',
      'status': 'Active',
      'initials': 'KG',
      'category': 'Manager',
      'country': 'United States',
      'state': 'California',
      'city': 'Los Angeles',
      'zip': '90001',
      'street': '',
      'notes': '',
    },
    {
      'name': 'Facility Vendor',
      'email': 'facility.vendor@konnect.com',
      'role': 'Vendor',
      'phone': '5866007450',
      'status': 'Inactive',
      'initials': 'FV',
      'category': 'Vendor',
      'country': 'United States',
      'state': 'New York',
      'city': 'New York City',
      'zip': '10001',
      'street': '',
      'notes': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const filters = ['All', 'Active', 'Inactive', 'Owner', 'Manager', 'Vendor'];

    final filtered =
        _users.where((user) {
          final query = _searchText.trim().toLowerCase();
          final matchSearch =
              query.isEmpty ||
              user['name']!.toLowerCase().contains(query) ||
              user['email']!.toLowerCase().contains(query) ||
              user['phone']!.toLowerCase().contains(query) ||
              user['role']!.toLowerCase().contains(query);
          final matchFilter =
              _selectedFilter == 'All' ||
              user['status'] == _selectedFilter ||
              user['category'] == _selectedFilter;
          return matchSearch && matchFilter;
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
                      'Users',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage all user profiles linked to your properties',
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
                child: const Icon(Icons.groups_rounded, color: Colors.white),
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
              hintText: 'Search by name, email, phone or role',
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
              'No users match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ...filtered.map((user) => _UserItemCard(user: user)),
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
      case 'Owner':
        return Icons.person_rounded;
      case 'Manager':
        return Icons.manage_accounts_rounded;
      case 'Vendor':
        return Icons.handyman_rounded;
      default:
        return Icons.layers_rounded;
    }
  }
}

class _UserItemCard extends StatelessWidget {
  const _UserItemCard({required this.user});

  final Map<String, String> user;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        user['status'] == 'Active' ? Colors.green : Colors.orange;

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
                    Icons.person_rounded,
                    color: Color(0xFF243B53),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] ?? '-',
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
                          _QuickTag(text: user['role'] ?? '-'),
                          _QuickTag(text: 'ID ${user['initials'] ?? 'NA'}'),
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
                    icon: Icons.mail_outline_rounded,
                    label: 'Email',
                    value: user['email'] ?? '-',
                  ),
                  _DetailRow(
                    icon: Icons.phone_rounded,
                    label: 'Phone',
                    value: user['phone'] ?? '-',
                  ),
                  _DetailRow(
                    icon: Icons.badge_outlined,
                    label: 'Role',
                    value: user['role'] ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(label: user['status'] ?? '-', color: statusColor),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ViewUserDetailsPage(user: user),
                      ),
                    );
                  },
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
                color: fgColor,
                fontSize: 12,
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
          Icon(icon, size: 16, color: Colors.blueGrey[400]),
          const SizedBox(width: 8),
          SizedBox(
            width: 95,
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

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
