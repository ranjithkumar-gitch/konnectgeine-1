import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KonnectGenie/authentication/login_screen.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);
const Color _kPageBackground = Color(0xFFF3F6FB);
const Color _kCardBorder = Color(0xFFE4E9F2);

class TenantDashboard extends StatefulWidget {
  const TenantDashboard({super.key});

  @override
  State<TenantDashboard> createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedPageIndex = 0;

  int get _bottomNavIndex {
    switch (_selectedPageIndex) {
      case 1:
        return 1;
      case 2:
        return 2;
      case 4:
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    final pageIndex =
        index == 1
            ? 1
            : index == 2
            ? 2
            : index == 3
            ? 4
            : 0;
    setState(() {
      _selectedPageIndex = pageIndex;
    });
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Text(
                  'Do you want to exit the app?',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        color: _kBrandSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Exit',
                      style: GoogleFonts.poppins(
                        color: _kBrandSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
        )) ??
        false;
  }

  void _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            title: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: _kBrandGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.power_settings_new_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _kBrandSecondary,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              'Are you sure you want to logout from your account?',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.35,
                color: const Color(0xFF334E68),
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _kBrandSecondary,
                  side: const BorderSide(color: Color(0xFFD6E2F5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kBrandSecondary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Logout',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
    );

    if (!mounted) return;

    if (shouldLogout == true) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  void _openProfilePage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const _TenantProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final exitApp = await _showExitDialog(context);
        if (!mounted) return;
        if (exitApp) {
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: _kPageBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: _kBrandGradient),
          ),
          title: const Text(
            'Konnect @Property',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: _kBrandGradient,
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(Icons.menu, color: Colors.white, size: 20),
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: _kBrandGradient,
                  border: Border.all(color: Colors.white24),
                ),
                child: const Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              tooltip: 'Logout',
              onPressed: _logout,
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFFF2F3F5),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                // ── Logo header ──────────────────────────────────────────
                Container(
                  height: 150,
                  padding: const EdgeInsets.fromLTRB(18, 32, 18, 16),
                  decoration: const BoxDecoration(gradient: _kBrandGradient),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/konnect_logo.png',
                            height: 145,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Menu items ───────────────────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                    children: [
                      _buildSidebarItem(
                        icon: Icons.dashboard_customize_rounded,
                        title: 'Dashboard',
                        isActive: _selectedPageIndex == 0,
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedPageIndex = 0);
                        },
                      ),
                      _buildSidebarItem(
                        icon: Icons.home_rounded,
                        title: 'My Property',
                        isActive: _selectedPageIndex == 1,
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedPageIndex = 1);
                        },
                      ),
                      _buildSidebarItem(
                        icon: Icons.apartment_rounded,
                        title: 'My Unit',
                        isActive: _selectedPageIndex == 2,
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedPageIndex = 2);
                        },
                      ),
                      _buildSidebarItem(
                        icon: Icons.handyman_rounded,
                        title: 'Service Requests',
                        isActive: _selectedPageIndex == 4,
                        onTap: () {
                          Navigator.pop(context);
                          setState(() => _selectedPageIndex = 4);
                        },
                      ),
                      _buildSidebarItem(
                        icon: Icons.account_circle_rounded,
                        title: 'My Profile',
                        isActive: false,
                        onTap: () {
                          Navigator.pop(context);
                          _openProfilePage();
                        },
                      ),
                    ],
                  ),
                ),
                // ── User footer ──────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F1A36),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF325DA9),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6D90D1),
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'MS',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Michael Smith',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tenant',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFAAB3CC),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFF0F1A36)),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                  child: Column(
                    children: [
                      const Divider(color: Color(0xFF263657), height: 1),
                      const SizedBox(height: 10),
                      Text(
                        '© 2026 Konnect@Property',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF5F6E8D),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _buildPage(),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: _kBrandGradient,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: _kBrandSecondary.withOpacity(0.28),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  currentIndex: _bottomNavIndex,
                  onTap: _onItemTapped,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  showUnselectedLabels: true,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded),
                      label: 'My Property',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.apartment),
                      label: 'My Unit',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assignment),
                      label: 'Requests',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (_selectedPageIndex) {
      case 0:
        return const _TenantDashboardPage();
      case 1:
        return const _TenantMyPropertyPage();
      case 2:
        return const _TenantMyUnitPage();
      case 3:
        return const _TenantPaymentsPage();
      case 4:
        return const _TenantRequestsPage();
      default:
        return const _TenantDashboardPage();
    }
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    final Color iconTileColor =
        isActive ? Colors.white.withOpacity(0.2) : const Color(0xFFE4E6EC);
    final Color textColor = isActive ? Colors.white : const Color(0xFF1F2937);
    final Color iconColor = isActive ? Colors.white : const Color(0xFF6B7280);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isActive ? const Color(0xFF2E5BA6) : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconTileColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// My Property Page
class _TenantMyPropertyPage extends StatefulWidget {
  const _TenantMyPropertyPage();

  @override
  State<_TenantMyPropertyPage> createState() => _TenantMyPropertyPageState();
}

class _TenantMyPropertyPageState extends State<_TenantMyPropertyPage> {
  String _search = '';
  String _statusFilter = 'All Status';
  String _typeFilter = 'All Types';

  static const List<Map<String, String>> _properties = [
    {
      'id': 'U20262',
      'name': 'The Heights',
      'city': 'Cincinnati',
      'type': 'Apartments/Condo',
      'occupancy': '-',
      'status': 'Active',
    },
  ];

  List<Map<String, String>> get _filtered {
    final query = _search.trim().toLowerCase();
    return _properties.where((p) {
      final haystack =
          '${p['id']} ${p['name']} ${p['city']} ${p['type']}'.toLowerCase();
      final matchesSearch = query.isEmpty || haystack.contains(query);
      final matchesStatus =
          _statusFilter == 'All Status' || p['status'] == _statusFilter;
      final matchesType =
          _typeFilter == 'All Types' || p['type'] == _typeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const _PageHeaderBanner(
          title: 'My Property',
          subtitle: 'Search and view your assigned property details.',
          icon: Icons.home_work_rounded,
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
            onChanged: (value) => setState(() => _search = value),
            decoration: InputDecoration(
              hintText: 'Search by property name, city or ID',
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
          children: [
            _TenantFilterPill(
              icon: Icons.layers_rounded,
              label: 'All Status',
              isActive: _statusFilter == 'All Status',
              onTap: () => setState(() => _statusFilter = 'All Status'),
            ),
            _TenantFilterPill(
              icon: Icons.check_circle_outline_rounded,
              label: 'Active',
              isActive: _statusFilter == 'Active',
              onTap: () => setState(() => _statusFilter = 'Active'),
            ),
            _TenantFilterPill(
              icon: Icons.home_work_outlined,
              label: 'All Types',
              isActive: _typeFilter == 'All Types',
              onTap: () => setState(() => _typeFilter = 'All Types'),
            ),
            _TenantFilterPill(
              icon: Icons.apartment_rounded,
              label: 'Apartments/Condo',
              isActive: _typeFilter == 'Apartments/Condo',
              onTap: () => setState(() => _typeFilter = 'Apartments/Condo'),
            ),
            _TenantFilterPill(
              icon: Icons.filter_alt_off_rounded,
              label: 'Clear',
              onTap: () {
                setState(() {
                  _search = '';
                  _statusFilter = 'All Status';
                  _typeFilter = 'All Types';
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 18),
        if (_filtered.isEmpty)
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
          ..._filtered.map(
            (property) => _TenantPropertyItemCard(
              property: property,
              onView: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const _TenantPropertyDetailsPage(),
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

class _TenantFilterPill extends StatelessWidget {
  const _TenantFilterPill({
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

class _TenantPropertyItemCard extends StatelessWidget {
  const _TenantPropertyItemCard({required this.property, required this.onView});

  final Map<String, String> property;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    final statusLabel = property['status'] ?? 'Unknown';
    final statusColor =
        statusLabel.toLowerCase() == 'active' ? Colors.green : Colors.orange;

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
                        property['name'] ?? '-',
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
                          _TenantPropertyQuickTag(
                            text: 'ID ${property['id'] ?? '-'}',
                          ),
                          _TenantPropertyQuickTag(
                            text: property['type'] ?? '-',
                          ),
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
                  _TenantPropertyDetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'City',
                    value: property['city'] ?? '-',
                  ),
                  _TenantPropertyDetailRow(
                    icon: Icons.people_outline_rounded,
                    label: 'Occupancy',
                    value: property['occupancy'] ?? '-',
                  ),
                  _TenantPropertyDetailRow(
                    icon: Icons.home_work_outlined,
                    label: 'Type',
                    value: property['type'] ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _TenantStatusChip(label: statusLabel, color: statusColor),
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

class _TenantPropertyQuickTag extends StatelessWidget {
  const _TenantPropertyQuickTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kBrandSecondary.withOpacity(0.18)),
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

class _TenantStatusChip extends StatelessWidget {
  const _TenantStatusChip({required this.label, required this.color});

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

class _TenantPropertyDetailRow extends StatelessWidget {
  const _TenantPropertyDetailRow({
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

class _TenantPropertyDetailsPage extends StatelessWidget {
  const _TenantPropertyDetailsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          'Property Details',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _PropertyDetailsSection(
            title: 'Basic Property Information',
            children: [
              _PropertyFormReadOnlyField(label: 'Property ID', value: '20264'),
              _PropertyFormReadOnlyField(
                label: 'Type *',
                value: 'Apartments/Condo',
              ),
              _PropertyFormReadOnlyField(
                label: 'Property Name *',
                value: 'The Heights',
              ),
              _PropertyFormReadOnlyField(
                label: 'Country *',
                value: 'United States',
              ),
              _PropertyFormReadOnlyField(label: 'State *', value: 'Ohio'),
              _PropertyFormReadOnlyField(label: 'City *', value: 'Cincinnati'),
              _PropertyFormReadOnlyField(
                label: 'Address *',
                value: '717 Martin Luther King Dr W',
              ),
              _PropertyFormReadOnlyField(label: 'ZIP Code *', value: '45220'),
              _PropertyFormReadOnlyField(
                label: 'Website',
                value: 'https://www.theheightsbyalbion.com/',
              ),
              _PropertyFormReadOnlyField(label: 'Status *', value: 'Active'),
              _PropertyFormReadOnlyField(label: 'Year Built', value: '2016'),
            ],
            fullWidthChild: _AmenitiesReadOnlyField(),
          ),
          const SizedBox(height: 18),
          const _PropertyDetailsSection(
            title: 'Contact Information',
            children: [
              _PropertyFormReadOnlyField(
                label: 'Contact Person',
                value: 'The Heights Sales Office',
              ),
              _PropertyFormReadOnlyField(
                label: 'Contact Person Mobile',
                value: '+1 5135551234',
              ),
              _PropertyFormReadOnlyField(
                label: 'Contact Person Email',
                value: 'sales@theheights.com',
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _PropertyDetailsSection(
            title: 'Developer Information',
            children: [
              _PropertyFormReadOnlyField(
                label: 'Developer Name',
                value: 'The Heights Development LLC',
              ),
              _PropertyFormReadOnlyField(
                label: 'Developer Email',
                value: 'info@theheightsdev.com',
              ),
              _PropertyFormReadOnlyField(
                label: 'Developer Mobile',
                value: '+1 5135555678',
              ),
            ],
            fullWidthChild: _PropertyFormReadOnlyField(
              label: 'Description',
              value: 'Premium mixed-use property with modern amenities.',
              minLines: 4,
            ),
          ),
          const SizedBox(height: 18),
          const _PropertyDetailsSection(
            title: 'Property Location',
            children: [
              _PropertyFormReadOnlyField(
                label: 'Search Address',
                value: '717 Martin Luther King Dr W',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LocationIconButton(icon: Icons.search_rounded),
                    SizedBox(width: 8),
                    _LocationIconButton(icon: Icons.layers_rounded),
                  ],
                ),
              ),
              _PropertyFormReadOnlyField(
                label: 'Coordinates',
                value: 'Lat: 39.1381772   Lng: -84.5233826',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PropertyDetailsSection extends StatelessWidget {
  const _PropertyDetailsSection({
    required this.title,
    required this.children,
    this.fullWidthChild,
  });

  final String title;
  final List<Widget> children;
  final Widget? fullWidthChild;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 12.0;
              final columns = constraints.maxWidth < 860 ? 1 : 3;
              final itemWidth =
                  (constraints.maxWidth - ((columns - 1) * spacing)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: 12,
                children:
                    children
                        .map(
                          (child) => SizedBox(width: itemWidth, child: child),
                        )
                        .toList(),
              );
            },
          ),
          if (fullWidthChild != null) ...[
            const SizedBox(height: 12),
            fullWidthChild!,
          ],
        ],
      ),
    );
  }
}

class _PropertyFormReadOnlyField extends StatelessWidget {
  const _PropertyFormReadOnlyField({
    required this.label,
    required this.value,
    this.minLines = 1,
    this.trailing,
  });

  final String label;
  final String value;
  final int minLines;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD8E0EA)),
          ),
          child: Row(
            crossAxisAlignment:
                minLines > 1
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: minLines > 1 ? minLines : 1,
                  overflow:
                      minLines > 1
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 10), trailing!],
            ],
          ),
        ),
      ],
    );
  }
}

class _AmenitiesReadOnlyField extends StatelessWidget {
  const _AmenitiesReadOnlyField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD8E0EA)),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _AmenityPillTag('CCTV'),
              _AmenityPillTag("Children's Play Area"),
              _AmenityPillTag('Clubhouse'),
              _AmenityPillTag('Community Hall'),
              _AmenityPillTag('Concierge'),
            ],
          ),
        ),
      ],
    );
  }
}

class _AmenityPillTag extends StatelessWidget {
  const _AmenityPillTag(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: _kBrandGradient,
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LocationIconButton extends StatelessWidget {
  const _LocationIconButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:
            icon == Icons.layers_rounded
                ? const Color(0xFFF59E0B)
                : const Color(0xFF3B82F6),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

// Dashboard Page
class _TenantDashboardPage extends StatelessWidget {
  const _TenantDashboardPage();

  String _dateLabel() {
    final now = DateTime.now();
    const weekdayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final hour12 = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';
    return '${weekdayNames[now.weekday - 1]}, ${monthNames[now.month - 1]} ${now.day}, ${now.year} · $hour12:$minute $ampm';
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required String caption,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required Color captionColor,
    required Color captionBg,
    bool compact = false,
  }) {
    return Container(
      padding: EdgeInsets.all(compact ? 14 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(compact ? 16 : 18),
        border: Border.all(color: const Color(0xFFDCE4F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF8B9AB4),
                    fontSize: compact ? 11.5 : 12.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Container(
                width: compact ? 38 : 44,
                height: compact ? 38 : 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(compact ? 12 : 14),
                ),
                child: Icon(icon, color: iconColor, size: compact ? 18 : 20),
              ),
            ],
          ),
          SizedBox(height: compact ? 10 : 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: const Color(0xFF1E293B),
              fontSize: compact ? 28 : 34,
              fontWeight: FontWeight.w700,
              height: 0.9,
            ),
          ),
          SizedBox(height: compact ? 8 : 10),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 10 : 12,
              vertical: compact ? 5 : 6,
            ),
            decoration: BoxDecoration(
              color: captionBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              caption,
              style: GoogleFonts.poppins(
                color: captionColor,
                fontSize: compact ? 11.5 : 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestStat(
    String label,
    String value,
    Color color, {
    bool compact = false,
  }) {
    return Container(
      height: compact ? 78 : 92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(compact ? 14 : 16),
        border: Border.all(color: const Color(0xFFDCE4F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color(0xFF667892),
              fontSize: compact ? 10.5 : 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: compact ? 4 : 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: compact ? 24 : 28,
              fontWeight: FontWeight.w700,
              height: 0.9,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 1180;
    final isMedium = width >= 720;
    final isCompact = width < 420;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good afternoon, Michael! 👋',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF0F172A),
                            fontSize: isCompact ? 18 : 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: isCompact ? 6 : 8),
                        Row(
                          children: [
                            Container(
                              width: isCompact ? 8 : 10,
                              height: isCompact ? 8 : 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF80D1B0),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Your home dashboard · My Property, My Unit & service requests',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF64748B),
                                  fontSize: isCompact ? 11 : 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isMedium)
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F4F9),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDDE3ED)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            size: 18,
                            color: Color(0xFF4B5563),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _dateLabel(),
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF4B5563),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        GridView.count(
          crossAxisCount: isWide ? 4 : (isMedium ? 2 : 1),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: isWide ? 1.9 : (isMedium ? 1.35 : 1.65),
          children: [
            _summaryCard(
              title: 'MY PROPERTY',
              value: '1',
              caption: 'Linked properties',
              icon: Icons.home_rounded,
              iconColor: const Color(0xFF2A58C3),
              iconBg: const Color(0xFFDCE6F9),
              captionColor: const Color(0xFF2A58C3),
              captionBg: const Color(0xFFDCE6F9),
              compact: !isMedium,
            ),
            _summaryCard(
              title: 'MY UNIT',
              value: '1',
              caption: 'Your unit(s)',
              icon: Icons.cottage_rounded,
              iconColor: const Color(0xFF0F7B59),
              iconBg: const Color(0xFFDDF3EA),
              captionColor: const Color(0xFF0F7B59),
              captionBg: const Color(0xFFDDF3EA),
              compact: !isMedium,
            ),
            _summaryCard(
              title: 'ALL REQUESTS',
              value: '0',
              caption: 'Total SR',
              icon: Icons.assignment_rounded,
              iconColor: const Color(0xFFA95A0A),
              iconBg: const Color(0xFFF9EBDB),
              captionColor: const Color(0xFFA95A0A),
              captionBg: const Color(0xFFF9EBDB),
              compact: !isMedium,
            ),
            _summaryCard(
              title: 'NEEDS ATTENTION',
              value: '0',
              caption: 'New + in progress',
              icon: Icons.notifications_rounded,
              iconColor: const Color(0xFF0A7C88),
              iconBg: const Color(0xFFDDF1F4),
              captionColor: const Color(0xFF5C2DCB),
              captionBg: const Color(0xFFE9DFFD),
              compact: !isMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _serviceRequestsPanel(compact: !isMedium),
      ],
    );
  }

  Widget _serviceRequestsPanel({required bool compact}) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(compact ? 16 : 20),
        border: Border.all(color: const Color(0xFFDCE4F0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA95A0A),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Service requests',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF1F2937),
                      fontSize: compact ? 15 : 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  'View all ->',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF2A58C3),
                    fontSize: compact ? 12 : 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFDCE4F0)),
          Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = compact || constraints.maxWidth < 760;
                if (isNarrow) {
                  final tileWidth = (constraints.maxWidth - 10) / 2;
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        width: tileWidth,
                        child: _requestStat(
                          'NEW',
                          '0',
                          const Color(0xFF2A58C3),
                          compact: true,
                        ),
                      ),
                      SizedBox(
                        width: tileWidth,
                        child: _requestStat(
                          'IN PROGRESS',
                          '0',
                          const Color(0xFFA95A0A),
                          compact: true,
                        ),
                      ),
                      SizedBox(
                        width: tileWidth,
                        child: _requestStat(
                          'CLOSED',
                          '0',
                          const Color(0xFF0F7B59),
                          compact: true,
                        ),
                      ),
                      SizedBox(
                        width: tileWidth,
                        child: _requestStat(
                          'REJECTED',
                          '0',
                          const Color(0xFFDC2626),
                          compact: true,
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _requestStat('NEW', '0', const Color(0xFF2A58C3)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _requestStat(
                        'IN PROGRESS',
                        '0',
                        const Color(0xFFA95A0A),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _requestStat(
                        'CLOSED',
                        '0',
                        const Color(0xFF0F7B59),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _requestStat(
                        'REJECTED',
                        '0',
                        const Color(0xFFDC2626),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: compact ? 12 : 24),
        ],
      ),
    );
  }
}

// My Unit Page
class _TenantMyUnitPage extends StatelessWidget {
  const _TenantMyUnitPage();

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
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const SizedBox(height: 8),
        const _PageHeaderBanner(
          title: 'My Unit',
          subtitle: 'Your lease, amenities, and essential unit details.',
          icon: Icons.apartment_rounded,
        ),
        const SizedBox(height: 20),
        _sectionHeader('My Unit Details', Icons.apartment_rounded),
        const SizedBox(height: 12),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Building A - Unit 301',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _kBrandSecondary,
                ),
              ),
              const SizedBox(height: 12),
              _DetailRow(label: 'Address', value: '123 Main Street, Mumbai'),
              const SizedBox(height: 8),
              _DetailRow(label: 'Lease Start', value: '01 Jan 2024'),
              const SizedBox(height: 8),
              _DetailRow(label: 'Lease End', value: '31 Dec 2025'),
              const SizedBox(height: 8),
              _DetailRow(label: 'Rent Amount', value: '₹25,000/month'),
              const SizedBox(height: 8),
              _DetailRow(label: 'Deposit Amount', value: '₹50,000'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sectionHeader('Amenities', Icons.star_rounded),
        const SizedBox(height: 12),
        _SectionCard(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _AmenityChip(label: 'WiFi'),
              _AmenityChip(label: 'Parking'),
              _AmenityChip(label: 'Gym'),
              _AmenityChip(label: 'Security'),
              _AmenityChip(label: 'Water Tank'),
              _AmenityChip(label: 'Generator'),
            ],
          ),
        ),
      ],
    );
  }
}

// Payments Page
class _TenantPaymentsPage extends StatelessWidget {
  const _TenantPaymentsPage();

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
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const SizedBox(height: 8),
        const _PageHeaderBanner(
          title: 'Payments',
          subtitle: 'Review rent, utility bills, and transaction statuses.',
          icon: Icons.receipt_long_rounded,
        ),
        const SizedBox(height: 20),
        _sectionHeader('Payment History', Icons.receipt_long_rounded),
        const SizedBox(height: 12),
        _SectionCard(
          child: Column(
            children: const [
              _PaymentCard(
                title: 'Rent Payment',
                date: '01 Mar 2024',
                amount: '₹25,000',
                status: 'Paid',
                statusColor: Colors.green,
              ),
              _PaymentCard(
                title: 'Electricity Bill',
                date: '15 Feb 2024',
                amount: '₹450',
                status: 'Pending',
                statusColor: Colors.orange,
              ),
              _PaymentCard(
                title: 'Water Bill',
                date: '10 Feb 2024',
                amount: '₹150',
                status: 'Paid',
                statusColor: Colors.green,
              ),
              _PaymentCard(
                title: 'Maintenance Fee',
                date: '01 Feb 2024',
                amount: '₹500',
                status: 'Paid',
                statusColor: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Requests Page
class _TenantRequestsPage extends StatefulWidget {
  const _TenantRequestsPage();

  @override
  State<_TenantRequestsPage> createState() => _TenantRequestsPageState();
}

class _TenantRequestsPageState extends State<_TenantRequestsPage> {
  String _selectedFilter = 'All';

  static const List<Map<String, String>> _requests = [
    {
      'id': 'REQ-001',
      'title': 'AC Not Working',
      'date': '18 Mar 2024',
      'status': 'In Progress',
      'priority': 'High',
    },
    {
      'id': 'REQ-002',
      'title': 'Water Leakage',
      'date': '15 Mar 2024',
      'status': 'Completed',
      'priority': 'High',
    },
    {
      'id': 'REQ-003',
      'title': 'Door Lock Repair',
      'date': '10 Mar 2024',
      'status': 'Pending',
      'priority': 'Medium',
    },
  ];

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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRequests =
        _selectedFilter == 'All'
            ? _requests
            : _requests
                .where((request) => request['status'] == _selectedFilter)
                .toList();

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const SizedBox(height: 8),
        const _PageHeaderBanner(
          title: 'Service Requests',
          subtitle: 'Raise and track maintenance requests with live status.',
          icon: Icons.assignment_rounded,
        ),
        const SizedBox(height: 20),
        _sectionHeader('My Requests', Icons.assignment_rounded),
        const SizedBox(height: 12),
        _SectionCard(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _kBrandSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              onPressed: () {},
              label: Text(
                'Raise New Request',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChip(
                label: 'All',
                isActive: _selectedFilter == 'All',
                onTap: () => setState(() => _selectedFilter = 'All'),
              ),
              _FilterChip(
                label: 'Pending',
                isActive: _selectedFilter == 'Pending',
                onTap: () => setState(() => _selectedFilter = 'Pending'),
              ),
              _FilterChip(
                label: 'In Progress',
                isActive: _selectedFilter == 'In Progress',
                onTap: () => setState(() => _selectedFilter = 'In Progress'),
              ),
              _FilterChip(
                label: 'Completed',
                isActive: _selectedFilter == 'Completed',
                onTap: () => setState(() => _selectedFilter = 'Completed'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...filteredRequests.map(
          (request) => _RequestCard(
            request: request,
            statusColor: _getStatusColor(request['status'] ?? ''),
          ),
        ),
      ],
    );
  }
}

// Helper Widgets

class _PageHeaderBanner extends StatelessWidget {
  const _PageHeaderBanner({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: _kBrandGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _kBrandSecondary.withOpacity(0.22),
            blurRadius: 16,
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
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.86),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  final String title;
  final int count;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 105;
        final iconSize = compact ? 16.0 : 20.0;
        final countSize = compact ? 15.0 : 18.0;
        final titleSize = compact ? 10.0 : 11.0;

        return Container(
          padding: EdgeInsets.all(compact ? 8 : 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kCardBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: iconSize),
              SizedBox(height: compact ? 4 : 8),
              Text(
                count.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: countSize,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              SizedBox(height: compact ? 2 : 4),
              Flexible(
                child: Text(
                  title,
                  maxLines: compact ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: titleSize,
                    color: const Color(0xFF697993),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          gradient: _kBrandGradient,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF697993),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class _AmenityChip extends StatelessWidget {
  const _AmenityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBrandSecondary.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _kBrandSecondary,
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusColor,
  });

  final String title;
  final String date;
  final String amount;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 380;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCardBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: _kBrandGradient,
                ),
                child: const Icon(
                  Icons.receipt_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF697993),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          isNarrow
              ? Row(
                children: [
                  Expanded(
                    child: Text(
                      amount,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _kBrandSecondary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amount,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kBrandSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request, required this.statusColor});

  final Map<String, String> request;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 380;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCardBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: _kBrandGradient,
                ),
                child: const Icon(
                  Icons.assignment_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['title'] ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      request['date'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF697993),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          isNarrow
              ? Row(
                children: [
                  Expanded(
                    child: Text(
                      request['id'] ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF8796AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      request['status'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request['id'] ?? '-',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF8796AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      request['status'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? null : Colors.white,
          gradient: isActive ? _kBrandGradient : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : const Color(0xFFE4E9F2),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : _kBrandSecondary,
          ),
        ),
      ),
    );
  }
}

// Profile Page
class _TenantProfilePage extends StatelessWidget {
  const _TenantProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageBackground,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
                        'My Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Review your account and residency details',
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
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _TenantProfileSectionCard(
            title: 'Basic User Information',
            children: [
              _TenantProfileReadOnlyField(
                label: 'Tenant Name',
                value: 'Michael Smith',
              ),
              _TenantProfileReadOnlyField(
                label: 'Email',
                value: 'michael.smith@konnectproperty.com',
              ),
              _TenantProfileReadOnlyField(
                label: 'Phone Number',
                value: '+91 98765 43210',
              ),
              _TenantProfileReadOnlyField(label: 'Status', value: 'Active'),
            ],
          ),
          const SizedBox(height: 16),
          const _TenantProfileSectionCard(
            title: 'Unit Information',
            children: [
              _TenantProfileReadOnlyField(
                label: 'Property Name',
                value: 'Green Valley Apartments',
              ),
              _TenantProfileReadOnlyField(label: 'Unit ID', value: 'UNIT-204'),
              _TenantProfileReadOnlyField(label: 'Unit Type', value: '2BHK'),
              _TenantProfileReadOnlyField(
                label: 'Lease Period',
                value: 'Jan 2026 - Dec 2026',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _TenantProfileSectionCard(
            title: 'Address Information',
            children: [
              _TenantProfileReadOnlyField(label: 'Country', value: 'India'),
              _TenantProfileReadOnlyField(label: 'State', value: 'Telangana'),
              _TenantProfileReadOnlyField(label: 'City', value: 'Hyderabad'),
              _TenantProfileReadOnlyField(
                label: 'ZIP/Postal Code',
                value: '500081',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PayRentQuickPage extends StatelessWidget {
  const _PayRentQuickPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageBackground,
      appBar: AppBar(
        title: Text(
          'Pay Rent',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _PageHeaderBanner(
            title: 'Rent Payment',
            subtitle: 'Make secure and quick payments for your monthly rent.',
            icon: Icons.payments_rounded,
          ),
          const SizedBox(height: 20),
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Dues',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kBrandSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                const _QuickInfoRow(label: 'Rent Amount', value: '₹25,000'),
                const SizedBox(height: 8),
                const _QuickInfoRow(label: 'Due Date', value: '25 Mar 2026'),
                const SizedBox(height: 8),
                const _QuickInfoRow(label: 'Late Fee', value: '₹0'),
                const Divider(height: 24),
                const _QuickInfoRow(label: 'Total Payable', value: '₹25,000'),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kBrandSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment gateway will be integrated.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.lock_rounded, color: Colors.white),
                    label: Text(
                      'Pay Securely',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RaiseRequestQuickPage extends StatefulWidget {
  const _RaiseRequestQuickPage();

  @override
  State<_RaiseRequestQuickPage> createState() => _RaiseRequestQuickPageState();
}

class _RaiseRequestQuickPageState extends State<_RaiseRequestQuickPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _priority = 'Medium';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageBackground,
      appBar: AppBar(
        title: Text(
          'Raise Request',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _PageHeaderBanner(
            title: 'Service Request',
            subtitle: 'Report issues and track maintenance requests instantly.',
            icon: Icons.playlist_add_circle_rounded,
          ),
          const SizedBox(height: 20),
          _SectionCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Title',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _titleController,
                    decoration: _quickInputDecoration('e.g. AC not cooling'),
                    validator:
                        (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Please enter title'
                                : null,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Priority',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _priority,
                    decoration: _quickInputDecoration('Select priority'),
                    items: const [
                      DropdownMenuItem(value: 'Low', child: Text('Low')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'High', child: Text('High')),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _priority = value);
                    },
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: _quickInputDecoration(
                      'Describe the issue in detail',
                    ),
                    validator:
                        (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Please enter description'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kBrandSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() != true) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Request submitted successfully.'),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                      label: Text(
                        'Submit Request',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentsQuickPage extends StatelessWidget {
  const _DocumentsQuickPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageBackground,
      appBar: AppBar(
        title: Text(
          'Documents',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _PageHeaderBanner(
            title: 'My Documents',
            subtitle: 'Access lease, payment receipts, and KYC records.',
            icon: Icons.folder_copy_rounded,
          ),
          const SizedBox(height: 20),
          _SectionCard(
            child: Column(
              children: const [
                _DocumentTile(
                  title: 'Lease Agreement.pdf',
                  subtitle: 'Updated on 05 Mar 2026',
                  icon: Icons.description_rounded,
                ),
                _DocumentTile(
                  title: 'Rent Receipt - Feb 2026.pdf',
                  subtitle: 'Updated on 01 Mar 2026',
                  icon: Icons.receipt_long_rounded,
                ),
                _DocumentTile(
                  title: 'KYC Document.pdf',
                  subtitle: 'Updated on 11 Jan 2026',
                  icon: Icons.badge_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportQuickPage extends StatelessWidget {
  const _SupportQuickPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kPageBackground,
      appBar: AppBar(
        title: Text('Support', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _PageHeaderBanner(
            title: 'Help & Support',
            subtitle:
                'Connect quickly with property support and emergency help.',
            icon: Icons.support_agent_rounded,
          ),
          const SizedBox(height: 20),
          _SectionCard(
            child: Column(
              children: [
                const _SupportTile(
                  title: 'Property Help Desk',
                  subtitle: '+91 90000 11111',
                  icon: Icons.call_rounded,
                ),
                const _SupportTile(
                  title: 'Emergency Contact',
                  subtitle: '+91 90000 22222',
                  icon: Icons.emergency_rounded,
                ),
                const _SupportTile(
                  title: 'Email Support',
                  subtitle: 'support@konnectproperty.com',
                  icon: Icons.mail_rounded,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kBrandSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Live chat will be enabled soon.'),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Start Live Chat',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration _quickInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.poppins(fontSize: 13),
    filled: true,
    fillColor: const Color(0xFFF8FAFF),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: _kCardBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: _kCardBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: _kBrandSecondary),
    ),
  );
}

class _QuickInfoRow extends StatelessWidget {
  const _QuickInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF5F6C85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: _kBrandSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kCardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: _kBrandGradient,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF697993),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Opening $title...')));
            },
            icon: const Icon(Icons.open_in_new_rounded),
            color: _kBrandSecondary,
          ),
        ],
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  const _SupportTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kCardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: _kBrandGradient,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF697993),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Connecting to $title...')),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            color: _kBrandSecondary,
          ),
        ],
      ),
    );
  }
}

class _TenantProfileSectionCard extends StatelessWidget {
  const _TenantProfileSectionCard({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 720;
                final spacing = 12.0;
                final columns = isMobile ? 1 : 2;
                final itemWidth =
                    (constraints.maxWidth - ((columns - 1) * spacing)) /
                    columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: 14,
                  children:
                      children
                          .map(
                            (child) => SizedBox(width: itemWidth, child: child),
                          )
                          .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TenantProfileReadOnlyField extends StatelessWidget {
  const _TenantProfileReadOnlyField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD9E2EC)),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF334E68),
            ),
          ),
        ),
      ],
    );
  }
}
