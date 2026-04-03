import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'my_requests_page.dart';
import '../authentication/login_screen.dart';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final NotchBottomBarController _notchController = NotchBottomBarController(
    index: 0,
  );
  int _selectedPageIndex = 0;

  final List<Widget> _pages = const [
    HomePage(), // 0 – Dashboard
    _TenantMyPropertyPage(), // 1 – My Property
    _TenantMyUnitPage(), // 2 – My Unit
    MyRequestsPage(), // 3 – Service Requests
    _TenantMyProfilePage(), // 4 – My Profile
  ];

  void _onDrawerNavTap(int index) {
    Navigator.pop(context);
    setState(() => _selectedPageIndex = index);
  }

  void _onBottomNavTap(int index) {
    final pageIndex =
        index == 1
            ? 3
            : index == 2
            ? 4
            : 0;
    setState(() {
      _selectedPageIndex = pageIndex;
      _notchController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _showLogoutDialog(context),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: _kBrandGradient),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          title: const Text(
            'Konnect @Property',
            style: TextStyle(color: Colors.white),
          ),
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
              onPressed: () async {
                final shouldLogout = await _showLogoutDialog(context);
                if (shouldLogout == true) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
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
                        onTap: () => _onDrawerNavTap(0),
                      ),
                      _buildSidebarItem(
                        icon: Icons.home_rounded,
                        title: 'My Property',
                        isActive: _selectedPageIndex == 1,
                        onTap: () => _onDrawerNavTap(1),
                      ),
                      _buildSidebarItem(
                        icon: Icons.apartment_rounded,
                        title: 'My Unit',
                        isActive: _selectedPageIndex == 2,
                        onTap: () => _onDrawerNavTap(2),
                      ),
                      _buildSidebarItem(
                        icon: Icons.handyman_rounded,
                        title: 'Service Requests',
                        isActive: _selectedPageIndex == 3,
                        onTap: () => _onDrawerNavTap(3),
                      ),
                      _buildSidebarItem(
                        icon: Icons.account_circle_rounded,
                        title: 'My Profile',
                        isActive: _selectedPageIndex == 4,
                        onTap: () => _onDrawerNavTap(4),
                      ),
                    ],
                  ),
                ),
                // ── User footer ──────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                  decoration: const BoxDecoration(color: Color(0xFF0F1A36)),
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
                          'RJ',
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
                              'Ranjith',
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
              ],
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pages[_selectedPageIndex],
        ),
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _notchController,
          color: _kBrandSecondary,
          showLabel: true,
          notchColor: const Color(0xFF2C5AA0),
          removeMargins: false,
          bottomBarWidth: 500,
          durationInMilliSeconds: 300,
          kIconSize: 26,
          kBottomRadius: 28.0,
          itemLabelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
          ),
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(Icons.home_outlined, color: Colors.white),
              activeItem: Icon(Icons.home, color: Colors.white),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.assignment_outlined,
                color: Colors.white,
              ),
              activeItem: Icon(Icons.assignment, color: Colors.white),
              itemLabel: 'My Requests',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.menu_outlined, color: Colors.white70),
              activeItem: Icon(Icons.menu, color: Colors.white),
              itemLabel: 'Menu',
            ),
          ],
          onTap: _onBottomNavTap,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
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

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return (await showDialog(
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
        )) ??
        false;
  }
}

// ─── Tenant Module Pages ─────────────────────────────────────────────────────

class _TenantMyPropertyPage extends StatelessWidget {
  const _TenantMyPropertyPage();

  static const List<Map<String, String>> _items = [
    {
      'id': 'PROP-01',
      'name': 'Green Valley Apartments',
      'secondary': 'Block B, 2nd Floor',
      'tag1': 'Residential',
      'tag2': '2BHK',
      'detail1': 'Kondapur, Hyderabad',
      'detail2': 'Property Manager: Arjun Mehta',
      'status': 'Active',
    },
    {
      'id': 'PROP-02',
      'name': 'Sunrise Residency',
      'secondary': 'Block A, Ground Floor',
      'tag1': 'Residential',
      'tag2': '1BHK',
      'detail1': 'Gachibowli, Hyderabad',
      'detail2': 'Property Manager: Revanth Kumar',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _TenantModulePage(
      title: 'My Property',
      subtitle: 'View your assigned property and lease details',
      heroIcon: Icons.home_rounded,
      searchHint: 'Search by property name or location',
      filters: ['All', 'Active', 'Pending'],
      items: _items,
      primaryKey: 'name',
      secondaryKey: 'secondary',
      leadingTagKey: 'id',
      trailingTagKey: 'tag1',
      detailOneLabel: 'Location',
      detailOneKey: 'detail1',
      detailTwoLabel: 'Manager',
      detailTwoKey: 'detail2',
      statusKey: 'status',
    );
  }
}

class _TenantMyUnitPage extends StatelessWidget {
  const _TenantMyUnitPage();

  static const List<Map<String, String>> _items = [
    {
      'id': 'UNIT-204',
      'name': 'Unit 204 – 2BHK',
      'secondary': 'Block B • Green Valley Apartments',
      'tag1': 'Floor 2',
      'tag2': 'Furnished',
      'detail1': 'Lease: Jan 2026 – Dec 2026',
      'detail2': r'Rent: $1,099 / month',
      'status': 'Active',
    },
    {
      'id': 'UNIT-105',
      'name': 'Unit 105 – 1BHK',
      'secondary': 'Block A • Sunrise Residency',
      'tag1': 'Ground Floor',
      'tag2': 'Semi-Furnished',
      'detail1': 'Lease: Jun 2025 – May 2026',
      'detail2': r'Rent: $750 / month',
      'status': 'Inactive',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _TenantModulePage(
      title: 'My Unit',
      subtitle: 'Track your unit details, lease period and rent',
      heroIcon: Icons.apartment_rounded,
      searchHint: 'Search by unit number or block',
      filters: ['All', 'Active', 'Inactive'],
      items: _items,
      primaryKey: 'name',
      secondaryKey: 'secondary',
      leadingTagKey: 'id',
      trailingTagKey: 'tag1',
      detailOneLabel: 'Lease Period',
      detailOneKey: 'detail1',
      detailTwoLabel: 'Rent',
      detailTwoKey: 'detail2',
      statusKey: 'status',
    );
  }
}

class _TenantMyProfilePage extends StatelessWidget {
  const _TenantMyProfilePage();

  static const List<Map<String, String>> _items = [
    {
      'id': 'PRF-01',
      'name': 'Ranjith Kumar',
      'secondary': 'Tenant – Primary',
      'tag1': 'Verified',
      'tag2': 'KYC Done',
      'detail1': 'ranjith@example.com',
      'detail2': '+91 98765 43210',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _TenantModulePage(
      title: 'My Profile',
      subtitle: 'Manage your personal details and verification status',
      heroIcon: Icons.account_circle_rounded,
      searchHint: 'Search profile details',
      filters: ['All', 'Active'],
      items: _items,
      primaryKey: 'name',
      secondaryKey: 'secondary',
      leadingTagKey: 'id',
      trailingTagKey: 'tag1',
      detailOneLabel: 'Email',
      detailOneKey: 'detail1',
      detailTwoLabel: 'Phone',
      detailTwoKey: 'detail2',
      statusKey: 'status',
    );
  }
}

// ─── Generic reusable module page ────────────────────────────────────────────

class _TenantModulePage extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData heroIcon;
  final String searchHint;
  final List<String> filters;
  final List<Map<String, String>> items;
  final String primaryKey;
  final String secondaryKey;
  final String leadingTagKey;
  final String trailingTagKey;
  final String detailOneLabel;
  final String detailOneKey;
  final String detailTwoLabel;
  final String detailTwoKey;
  final String statusKey;

  const _TenantModulePage({
    required this.title,
    required this.subtitle,
    required this.heroIcon,
    required this.searchHint,
    required this.filters,
    required this.items,
    required this.primaryKey,
    required this.secondaryKey,
    required this.leadingTagKey,
    required this.trailingTagKey,
    required this.detailOneLabel,
    required this.detailOneKey,
    required this.detailTwoLabel,
    required this.detailTwoKey,
    required this.statusKey,
  });

  @override
  State<_TenantModulePage> createState() => _TenantModulePageState();
}

class _TenantModulePageState extends State<_TenantModulePage> {
  late String _selectedFilter;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.filters.first;
  }

  List<Map<String, String>> get _visibleItems {
    final query = _query.trim().toLowerCase();
    return widget.items.where((item) {
      final status = item[widget.statusKey] ?? '';
      final matchesFilter =
          _selectedFilter == 'All' || status == _selectedFilter;
      final haystack = item.values.join(' ').toLowerCase();
      final matchesSearch = query.isEmpty || haystack.contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  Color _statusColor(String label) {
    switch (label) {
      case 'Active':
      case 'Paid':
        return const Color(0xFF0F766E);
      case 'Pending':
      case 'In Progress':
        return const Color(0xFFB45309);
      case 'Inactive':
        return Colors.blueGrey;
      default:
        return const Color(0xFF1D4ED8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        // Hero banner
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
                      widget.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.subtitle,
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
                child: Icon(widget.heroIcon, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Search
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
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: widget.searchHint,
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
        // Filter pills
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children:
              widget.filters
                  .map(
                    (f) => _TenantFilterPill(
                      label: f,
                      isActive: _selectedFilter == f,
                      onTap: () => setState(() => _selectedFilter = f),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 18),
        // Cards
        if (_visibleItems.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'No records match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ..._visibleItems.map((item) {
            final status = item[widget.statusKey] ?? '-';
            final statusColor = _statusColor(status);
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
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD9E2EC), Color(0xFFBCCCDC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: Color(0xFF243B53),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item[widget.primaryKey] ?? '-',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item[widget.secondaryKey] ?? '-',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF829AB1),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  _TenantQuickTag(
                                    text: item[widget.leadingTagKey] ?? '-',
                                  ),
                                  _TenantQuickTag(
                                    text: item[widget.trailingTagKey] ?? '-',
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
                          _TenantDetailRow(
                            icon: Icons.info_outline_rounded,
                            label: widget.detailOneLabel,
                            value: item[widget.detailOneKey] ?? '-',
                          ),
                          _TenantDetailRow(
                            icon: Icons.badge_outlined,
                            label: widget.detailTwoLabel,
                            value: item[widget.detailTwoKey] ?? '-',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blueGrey.shade100),
                            foregroundColor: _kBrandSecondary,
                          ),
                          icon: const Icon(Icons.visibility_outlined, size: 18),
                          label: Text(
                            'View',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _TenantFilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TenantFilterPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive ? _kBrandGradient : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : const Color(0xFFD6E2F5),
          ),
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: _kBrandSecondary.withOpacity(0.22),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF486581),
          ),
        ),
      ),
    );
  }
}

class _TenantQuickTag extends StatelessWidget {
  final String text;

  const _TenantQuickTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF0F7),
        borderRadius: BorderRadius.circular(10),
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

class _TenantDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _TenantDetailRow({
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
          Icon(icon, size: 16, color: const Color(0xFF829AB1)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF486581),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF627D98),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
