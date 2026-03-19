import 'package:KonnectGenie/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _kBrandBlue = Color(0xFF2F65CB);
const Color _kBrandNavy = Color(0xFF0F2352);
const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2F65CB), Color(0xFF0F2352)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const Color _kBackground = Color(0xFFF3F5F9);
const Color _kCard = Colors.white;

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  int get _bottomNavIndex => _selectedIndex > 3 ? 0 : _selectedIndex;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.dashboard_rounded, 'Dashboard'),
    _NavItem(Icons.apartment_rounded, 'Property Managers'),
    _NavItem(Icons.groups_rounded, 'My Staff'),
    _NavItem(Icons.build_circle_rounded, 'Service Requests'),
    _NavItem(Icons.person_rounded, 'My Profile'),
    _NavItem(Icons.assessment_rounded, 'Reports'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, _navItems.length - 1);
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                title: Text(
                  'Exit app?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),
                content: Text(
                  'Do you want to close Konnect@Property?',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF4A5568),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _kBrandBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Exit',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
        )) ??
        false;
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _kBrandBlue,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Logout',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            content: Text(
              'Are you sure you want to logout from your account?',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF4A5568),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: _kBrandBlue),
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
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Widget _buildCurrentPage(bool compact) {
    if (_selectedIndex == 0) {
      return _VendorDashboardOverview(compact: compact);
    } else if (_selectedIndex == 1) {
      return const _PropertyManagersPage();
    } else if (_selectedIndex == 2) {
      return const _StaffListPage();
    } else if (_selectedIndex == 3) {
      return const _ServiceRequestsPage();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E9F2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _navItems[_selectedIndex].icon,
                size: 42,
                color: _kBrandBlue,
              ),
              const SizedBox(height: 12),
              Text(
                _navItems[_selectedIndex].label,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _kBrandNavy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This module is ready for API integration.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF5F6C85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth >= 1080;
          final bool compact = constraints.maxWidth < 760;

          if (isDesktop) {
            return Scaffold(
              backgroundColor: _kBackground,
              body: SafeArea(
                child: Row(
                  children: [
                    _VendorSidebar(
                      items: _navItems,
                      selectedIndex: _selectedIndex,
                      onSelect:
                          (index) => setState(() => _selectedIndex = index),
                      onLogout: _logout,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _DesktopTopBar(onLogout: _logout),
                          Expanded(child: _buildCurrentPage(compact)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: _kBackground,
            drawer: Drawer(
              child: _VendorSidebar(
                items: _navItems,
                selectedIndex: _selectedIndex,
                onSelect: (index) {
                  setState(() => _selectedIndex = index);
                  Navigator.of(context).pop();
                },
                onLogout: _logout,
                inDrawer: true,
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleSpacing: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: _kBrandGradient),
              ),
              leading: IconButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: _kBrandGradient,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(Icons.menu, color: Colors.white, size: 20),
                ),
              ),
              title: Text(
                'Konnect @Property',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: _kBrandGradient,
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _logout,
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
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: _buildCurrentPage(compact),
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
                        color: _kBrandNavy.withValues(alpha: 0.28),
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
                      onTap: (index) => setState(() => _selectedIndex = index),
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
                          icon: Icon(Icons.apartment),
                          label: 'Managers',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.groups),
                          label: 'Staff',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.build_circle),
                          label: 'Requests',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DesktopTopBar extends StatelessWidget {
  const _DesktopTopBar({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140E234A),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: _kBrandNavy,
                ),
              ),
              Text(
                'Home / Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF7C8AA5),
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded, color: _kBrandNavy),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: _kBrandBlue,
                  child: Text('G', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Gupta!',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _kBrandNavy,
                      ),
                    ),
                    Text(
                      'Vendor Admin',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF6B7A95),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDE2F2F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onLogout,
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: Text(
              'Logout',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorSidebar extends StatelessWidget {
  const _VendorSidebar({
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    required this.onLogout,
    this.inDrawer = false,
  });

  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;
  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inDrawer ? double.infinity : 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: const Color(0xFFE5EAF3),
            width: inDrawer ? 0 : 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(gradient: _kBrandGradient),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=28',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gupta Sharma',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Vendor Admin',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (int index = 0; index < items.length; index++)
                    _menuTile(
                      icon: items[index].icon,
                      label: items[index].label,
                      selected: selectedIndex == index,
                      onTap: () => onSelect(index),
                    ),
                  const Divider(height: 24),
                  _menuTile(
                    icon: Icons.logout_rounded,
                    label: 'Logout',
                    selected: false,
                    onTap: onLogout,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Text(
                '© 2026 Konnect@Property',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8EA0BE),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: selected ? const Color(0xFFF0F4FF) : null,
        leading: Icon(icon, color: _kBrandNavy),
        title: Text(
          label,
          style: GoogleFonts.poppins(
            color: _kBrandNavy,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class _VendorDashboardOverview extends StatelessWidget {
  const _VendorDashboardOverview({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(compact ? 14 : 20, 8, compact ? 14 : 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GreetingCard(compact: compact),
          const SizedBox(height: 12),
          _VendorIdCard(compact: compact),
          const SizedBox(height: 12),
          _KpiCards(compact: compact),
          const SizedBox(height: 12),
          const _ActiveServiceRequestsCard(),
          const SizedBox(height: 12),
          _ThreePaneRow(compact: compact),
          const SizedBox(height: 12),
          _BottomRow(compact: compact),
        ],
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  const _GreetingCard({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 14 : 20),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning, Gupta! 👋',
                    style: GoogleFonts.poppins(
                      fontSize: compact ? 20 : 30,
                      fontWeight: FontWeight.w700,
                      color: _kBrandNavy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '• Live dashboard · Last updated just now',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF697993),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Wednesday, March 18, 2026',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5D6C88),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F8EF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFABDEBE)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: compact ? double.infinity : 600,
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3DBD76),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Verified & Active',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF186A49),
                              ),
                            ),
                            Text(
                              'Your KYC documents have been approved. You are fully active.',
                              maxLines: compact ? 3 : 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF2E7F5E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: _kBrandBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'View Profile',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _kBrandNavy,
                        side: const BorderSide(color: Color(0xFFBDD5FB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Service Requests',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorIdCard extends StatelessWidget {
  const _VendorIdCard({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 14 : 20),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 12,
        children: [
          SizedBox(
            width: compact ? double.infinity : 420,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF1FF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'VENDOR ID CARD',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      letterSpacing: 1,
                      color: _kBrandBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Gupta',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: _kBrandNavy,
                  ),
                ),
                Text(
                  'Hyderabad Facility Care Pvt Ltd',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF60728F),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F8FF),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: const Color(0xFFE3EAFE)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'VENDOR CODE',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF6A7C97),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '2026008',
                        style: GoogleFonts.poppins(
                          color: _kBrandBlue,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '• KYC Approved  ·  Active Vendor',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF3D8A63),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF2658C7),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    color: Color(0xFF2658C7),
                    size: 74,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '2026008',
                  style: GoogleFonts.poppins(
                    letterSpacing: 2,
                    color: _kBrandBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Scan to verify',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF8896AB),
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

class _KpiCards extends StatelessWidget {
  const _KpiCards({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final cards = [
      const _KpiData(
        'NEW REQUESTS',
        '0',
        'awaiting response',
        Color(0xFF3B78E3),
        Color(0xFFEAF0FF),
      ),
      const _KpiData(
        'IN PROGRESS',
        '0',
        '0 due today',
        Color(0xFFDA9217),
        Color(0xFFFFF6E9),
      ),
      const _KpiData(
        'COMPLETED',
        '2',
        'total jobs done',
        Color(0xFF26B377),
        Color(0xFFEAFBF2),
      ),
      const _KpiData(
        'OVERDUE',
        '0',
        'needs attention',
        Color(0xFFE94A4A),
        Color(0xFFFFEFEF),
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          cards
              .map(
                (item) => SizedBox(
                  width: compact ? double.infinity : 260,
                  child: _KpiCard(data: item),
                ),
              )
              .toList(),
    );
  }
}

class _KpiData {
  const _KpiData(
    this.title,
    this.value,
    this.caption,
    this.color,
    this.bgColor,
  );

  final String title;
  final String value;
  final String caption;
  final Color color;
  final Color bgColor;
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.data});

  final _KpiData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              letterSpacing: 0.3,
              color: const Color(0xFF7A88A1),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.value,
            style: GoogleFonts.poppins(
              fontSize: 38,
              height: 1,
              color: _kBrandNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data.caption,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: data.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFFE7EDF8),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              widthFactor: data.value == '2' ? 1 : 0,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveServiceRequestsCard extends StatelessWidget {
  const _ActiveServiceRequestsCard();

  @override
  Widget build(BuildContext context) {
    final requests = [
      const _RequestData(
        id: 'KP-SR-11',
        request: 'Kitchen deep cleaning request',
        location: 'Hyderabad',
        priority: 'Medium',
        status: 'WorkCompleted',
        deadline: 'Mar 13',
        highlight: true,
      ),
      const _RequestData(
        id: 'KP-SR-10',
        request: 'Bathroom pipeline leakage',
        location: 'Hyderabad',
        priority: 'High',
        status: 'Closed',
        deadline: 'Mar 12',
      ),
    ];

    return _SectionCard(
      dotColor: const Color(0xFFF4A324),
      title: 'Active Service Requests',
      trailing: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _FilterChip(label: 'All (2)', selected: true),
          _FilterChip(label: 'New (0)'),
          _FilterChip(label: 'In Progress (0)'),
          _FilterChip(label: 'Overdue (0)'),
          TextButton(
            onPressed: () {},
            child: Text(
              'View All →',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F9FE)),
          columnSpacing: 30,
          columns: [
            _head('SR ID'),
            _head('REQUEST'),
            _head('PRIORITY'),
            _head('STATUS'),
            _head('DEADLINE'),
            _head(''),
          ],
          rows:
              requests
                  .map(
                    (item) => DataRow(
                      color:
                          item.highlight
                              ? WidgetStateProperty.all(const Color(0xFFFFF4F4))
                              : null,
                      cells: [
                        DataCell(
                          Text(
                            item.id,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF2F65CB),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 270,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.request,
                                  style: GoogleFonts.poppins(
                                    color: _kBrandNavy,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.location,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6D7A90),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          _StatusPill(item.priority, const Color(0xFFDA9217)),
                        ),
                        DataCell(
                          _StatusPill(item.status, const Color(0xFF29A976)),
                        ),
                        DataCell(
                          Text(
                            item.deadline,
                            style: GoogleFonts.poppins(
                              color:
                                  item.highlight
                                      ? const Color(0xFFDA3C3C)
                                      : const Color(0xFF596986),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Update',
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  DataColumn _head(String text) {
    return DataColumn(
      label: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF7A88A1),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE8EEFF) : const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? const Color(0xFFC8D7FD) : const Color(0xFFE4E9F2),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected ? _kBrandBlue : const Color(0xFF5C6B86),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _RequestData {
  const _RequestData({
    required this.id,
    required this.request,
    required this.location,
    required this.priority,
    required this.status,
    required this.deadline,
    this.highlight = false,
  });

  final String id;
  final String request;
  final String location;
  final String priority;
  final String status;
  final String deadline;
  final bool highlight;
}

class _ThreePaneRow extends StatelessWidget {
  const _ThreePaneRow({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final children = [
      const _SectionCard(
        title: 'Property Managers',
        dotColor: Color(0xFF8C61FF),
        trailing: Text('View all →', style: TextStyle(color: _kBrandBlue)),
        child: _PropertyManagersBody(),
      ),
      const _SectionCard(
        title: 'Performance Score',
        dotColor: Color(0xFF26B0D8),
        trailing: _Tag(text: 'Based on SRs'),
        child: _PerformanceBody(),
      ),
      const _SectionCard(
        title: 'Earnings Overview',
        dotColor: Color(0xFF29B173),
        trailing: Icon(Icons.remove_rounded, color: Color(0xFF8796AF)),
        child: _EarningsBody(),
      ),
    ];

    if (compact) {
      return Column(
        children:
            children
                .map(
                  (w) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: w,
                  ),
                )
                .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i != children.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  const _BottomRow({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final children = [
      const _SectionCard(
        title: 'Quick Actions',
        dotColor: Color(0xFF8C61FF),
        child: _QuickActionsBody(),
      ),
      const _SectionCard(
        title: "Today's Schedule",
        dotColor: Color(0xFF26B0D8),
        trailing: Text('Calendar →', style: TextStyle(color: _kBrandBlue)),
        child: _ScheduleBody(),
      ),
      const _SectionCard(
        title: 'Workload by Priority',
        dotColor: Color(0xFF2F65CB),
        child: _WorkloadBody(),
      ),
    ];

    if (compact) {
      return Column(
        children:
            children
                .map(
                  (w) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: w,
                  ),
                )
                .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i != children.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.dotColor,
    required this.child,
    this.trailing,
  });

  final String title;
  final Color dotColor;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final bool isNarrow = MediaQuery.of(context).size.width < 760;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trailing != null && isNarrow)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _kBrandNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(alignment: Alignment.centerLeft, child: trailing!),
              ],
            )
          else
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _kBrandNavy,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFBF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: const Color(0xFF289A67),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PropertyManagersBody extends StatelessWidget {
  const _PropertyManagersBody();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your active PM network',
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B7A95),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF8796AF),
              ),
              const SizedBox(width: 8),
              Text(
                'PM list from API when available.',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF7D8BA3),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PerformanceBody extends StatelessWidget {
  const _PerformanceBody();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Column(
        children: [
          Text(
            '100/100',
            style: GoogleFonts.poppins(
              fontSize: 44,
              height: 1,
              color: _kBrandNavy,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Overall',
            style: GoogleFonts.poppins(color: const Color(0xFF6A7893)),
          ),
          const SizedBox(height: 14),
          _MetricLine('Response Time', 1, const Color(0xFF29B173)),
          _MetricLine('Job Completion', 1, const Color(0xFF2F65CB)),
          _MetricLine('Rating', 0, const Color(0xFFDA9217), value: '—'),
          _MetricLine('Overdue Rate', 0, const Color(0xFFE94A4A)),
        ],
      ),
    );
  }
}

class _MetricLine extends StatelessWidget {
  _MetricLine(this.title, this.valueFactor, this.color, {String? value})
    : value = value ?? '${(valueFactor * 100).toInt()}%';

  final String title;
  final double valueFactor;
  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF677791),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE4E9F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                widthFactor: valueFactor,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 34,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _kBrandNavy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningsBody extends StatelessWidget {
  const _EarningsBody();

  @override
  Widget build(BuildContext context) {
    final styleLabel = GoogleFonts.poppins(
      fontSize: 12,
      color: const Color(0xFF6C7A94),
      fontWeight: FontWeight.w500,
    );

    return SizedBox(
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MetricTop(
                title: 'Received',
                value: '—',
                color: const Color(0xFF26B377),
              ),
              _MetricTop(
                title: 'Pending',
                value: '—',
                color: const Color(0xFFDA9217),
              ),
              _MetricTop(
                title: 'Avg per job',
                value: '—',
                color: const Color(0xFF475569),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text('Completed Jobs', style: styleLabel),
              const Spacer(),
              Text(
                '2',
                style: styleLabel.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _kBrandNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('Top PM (Revenue)', style: styleLabel),
              const Spacer(),
              Text(
                '—',
                style: styleLabel.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _kBrandNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Earnings data from API when available.', style: styleLabel),
        ],
      ),
    );
  }
}

class _MetricTop extends StatelessWidget {
  const _MetricTop({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF7A88A1),
          ),
        ),
      ],
    );
  }
}

class _QuickActionsBody extends StatelessWidget {
  const _QuickActionsBody();

  @override
  Widget build(BuildContext context) {
    final actions = [
      const _ActionData(
        'New Request',
        '0 pending',
        Icons.shopping_bag_outlined,
        Color(0xFF2F65CB),
      ),
      const _ActionData(
        'My Profile',
        'View & edit',
        Icons.person_rounded,
        Color(0xFF26B377),
      ),
      const _ActionData(
        'In Progress',
        '0 active',
        Icons.bolt_rounded,
        Color(0xFFDA9217),
      ),
      const _ActionData(
        'All SRs',
        'View all',
        Icons.list_alt_rounded,
        Color(0xFF7F56D9),
      ),
      const _ActionData(
        'View Reports',
        'Service requests',
        Icons.assessment_rounded,
        Color(0xFF2CAED6),
      ),
      const _ActionData(
        'Overdue',
        '0 overdue',
        Icons.warning_amber_rounded,
        Color(0xFFE94A4A),
      ),
    ];

    return SizedBox(
      height: 210,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: actions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.55,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final item = actions[index];
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: item.color.withValues(alpha: 0.15),
                  child: Icon(item.icon, color: item.color, size: 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _kBrandNavy,
                        ),
                      ),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF7B88A2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionData {
  const _ActionData(this.title, this.subtitle, this.icon, this.color);

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class _ScheduleBody extends StatelessWidget {
  const _ScheduleBody();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE4E9F2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.horizontal_rule_rounded, color: Color(0xFF2F65CB)),
            const SizedBox(width: 10),
            Text(
              'No visits scheduled for today.',
              style: GoogleFonts.poppins(color: const Color(0xFF687893)),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkloadBody extends StatelessWidget {
  const _WorkloadBody();

  @override
  Widget build(BuildContext context) {
    final workload = [
      const _PriorityData('Low', 0, Color(0xFF8E99AB)),
      const _PriorityData('Medium', 1, Color(0xFF2F65CB)),
      const _PriorityData('High', 1, Color(0xFFE06513)),
      const _PriorityData('Urgent', 0, Color(0xFFE94A4A)),
    ];

    return SizedBox(
      height: 210,
      child: Column(
        children:
            workload
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 78,
                          child: Text(
                            item.label,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF65738D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5EAF4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: item.value / 2,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: item.color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 18,
                          child: Text(
                            '${item.value}',
                            textAlign: TextAlign.end,
                            style: GoogleFonts.poppins(
                              color: _kBrandNavy,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _PriorityData {
  const _PriorityData(this.label, this.value, this.color);

  final String label;
  final int value;
  final Color color;
}

class _NavItem {
  const _NavItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _PropertyManagersPage extends StatefulWidget {
  const _PropertyManagersPage();

  @override
  State<_PropertyManagersPage> createState() => _PropertyManagersPageState();
}

class _PropertyManagersPageState extends State<_PropertyManagersPage> {
  static const List<Map<String, String>> _seedManagers = [
    {
      'id': 'PM-001',
      'name': 'Arjun Mehta',
      'company': 'PropTech Solutions',
      'phone': '9876543210',
      'email': 'arjun.mehta@proptech.in',
      'status': 'Active',
      'properties': '2',
      'rating': '4.8',
    },
    {
      'id': 'PM-002',
      'name': 'Revanth Kumar',
      'company': 'Urban Property Mgmt',
      'phone': '9765432109',
      'email': 'revanth@urban.in',
      'status': 'Active',
      'properties': '3',
      'rating': '4.5',
    },
    {
      'id': 'PM-003',
      'name': 'Priya Sharma',
      'company': 'Elite Properties',
      'phone': '9654321098',
      'email': 'priya@elite.in',
      'status': 'Inactive',
      'properties': '1',
      'rating': '4.2',
    },
  ];

  late final List<Map<String, String>> _allManagers;
  late List<Map<String, String>> _visibleManagers;
  String _query = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _allManagers = List<Map<String, String>>.from(_seedManagers);
    _visibleManagers = List<Map<String, String>>.from(_allManagers);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
      _applyFilters();
    });
  }

  void _applyFilters() {
    bool matchesFilter(Map<String, String> item) {
      if (_selectedFilter == 'All') return true;
      return (item['status'] ?? '') == _selectedFilter;
    }

    bool matchesQuery(Map<String, String> item) {
      if (_query.isEmpty) return true;
      return (item['name'] ?? '').toLowerCase().contains(_query) ||
          (item['company'] ?? '').toLowerCase().contains(_query) ||
          (item['email'] ?? '').toLowerCase().contains(_query);
    }

    _visibleManagers =
        _allManagers
            .where((item) => matchesFilter(item) && matchesQuery(item))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          24 + kBottomNavigationBarHeight,
        ),
        children: [
          _sectionHeader('Property Managers', Icons.group_rounded),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE4E9F2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name, company, or email',
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
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChipWidget(
                icon: Icons.layers_rounded,
                label: 'All',
                isActive: _selectedFilter == 'All',
                onTap: () => _onFilterChanged('All'),
              ),
              _FilterChipWidget(
                icon: Icons.verified_rounded,
                label: 'Active',
                isActive: _selectedFilter == 'Active',
                onTap: () => _onFilterChanged('Active'),
              ),
              _FilterChipWidget(
                icon: Icons.block_rounded,
                label: 'Inactive',
                isActive: _selectedFilter == 'Inactive',
                onTap: () => _onFilterChanged('Inactive'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (_visibleManagers.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4E9F2)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_off_rounded,
                    size: 48,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No managers found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _kBrandNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Try adjusting your search or filter',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF697993),
                    ),
                  ),
                ],
              ),
            )
          else
            ..._visibleManagers.map(
              (manager) => _ManagerCard(manager: manager),
            ),
        ],
      ),
    );
  }

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
}

class _FilterChipWidget extends StatelessWidget {
  const _FilterChipWidget({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive ? _kBrandGradient : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : const Color(0xFFE4E9F2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isActive ? Colors.white : _kBrandNavy),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : _kBrandNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagerCard extends StatelessWidget {
  const _ManagerCard({required this.manager});

  final Map<String, String> manager;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        manager['status'] == 'Active'
            ? const Color(0xFF26B377)
            : Colors.grey[400];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
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
                  shape: BoxShape.circle,
                  gradient: _kBrandGradient,
                ),
                child: Center(
                  child: Text(
                    (manager['name'] ?? 'PM')[0].toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      manager['name'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      manager['company'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF697993),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: (statusColor ?? Colors.grey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: (statusColor ?? Colors.grey).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  manager['status'] ?? 'Unknown',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor ?? Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: manager['email'] ?? '-',
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: manager['phone'] ?? '-',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.apartment_rounded,
                      size: 16,
                      color: const Color(0xFF8796AF),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Properties',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      manager['properties'] ?? '0',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _kBrandNavy,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrandNavy,
                    side: const BorderSide(color: Color(0xFFBDD5FB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 14),
                  label: Text('View', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrandNavy,
                    side: const BorderSide(color: Color(0xFFBDD5FB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: Text('Edit', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF8796AF)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF5F6C85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kBrandNavy,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StaffListPage extends StatefulWidget {
  const _StaffListPage();

  @override
  State<_StaffListPage> createState() => _StaffListPageState();
}

class _StaffListPageState extends State<_StaffListPage> {
  static const List<Map<String, String>> _seedStaff = [
    {
      'id': 'STF-001',
      'name': 'Rajesh Patel',
      'role': 'Property Maintenance',
      'phone': '9876543210',
      'email': 'rajesh@vendor.in',
      'status': 'Active',
      'joined': 'Jan 2024',
    },
    {
      'id': 'STF-002',
      'name': 'Divya Singh',
      'role': 'Tenant Support',
      'phone': '9765432109',
      'email': 'divya@vendor.in',
      'status': 'Active',
      'joined': 'Feb 2024',
    },
    {
      'id': 'STF-003',
      'name': 'Vikram Kumar',
      'role': 'Inspection Lead',
      'phone': '9654321098',
      'email': 'vikram@vendor.in',
      'status': 'On Leave',
      'joined': 'Mar 2023',
    },
    {
      'id': 'STF-004',
      'name': 'Priya Sharma',
      'role': 'Billing Officer',
      'phone': '9543210987',
      'email': 'priya@vendor.in',
      'status': 'Active',
      'joined': 'Apr 2024',
    },
  ];

  late List<Map<String, String>> _allStaff;
  late List<Map<String, String>> _visibleStaff;
  String _query = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _allStaff = List<Map<String, String>>.from(_seedStaff);
    _visibleStaff = List<Map<String, String>>.from(_allStaff);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
      _applyFilters();
    });
  }

  void _applyFilters() {
    bool matchesFilter(Map<String, String> item) {
      if (_selectedFilter == 'All') return true;
      return (item['status'] ?? '') == _selectedFilter;
    }

    bool matchesQuery(Map<String, String> item) {
      if (_query.isEmpty) return true;
      return (item['name'] ?? '').toLowerCase().contains(_query) ||
          (item['role'] ?? '').toLowerCase().contains(_query) ||
          (item['email'] ?? '').toLowerCase().contains(_query);
    }

    _visibleStaff =
        _allStaff
            .where((item) => matchesFilter(item) && matchesQuery(item))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    final activeCount =
        _allStaff.where((staff) => (staff['status'] ?? '') == 'Active').length;
    final onLeaveCount =
        _allStaff
            .where((staff) => (staff['status'] ?? '') == 'On Leave')
            .length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          24 + kBottomNavigationBarHeight,
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: _kBrandGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _kBrandNavy.withOpacity(0.22),
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
                        'Vendor Staff',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Manage your staff details, contacts, and role assignments.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.86),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.groups_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE4E9F2)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$activeCount',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF26B377),
                        ),
                      ),
                      Text(
                        'Active',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE4E9F2)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$onLeaveCount',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFB800),
                        ),
                      ),
                      Text(
                        'On Leave',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 66,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kBrandNavy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const _VendorStaffEditorPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
                    label: Text(
                      'Add',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _sectionHeader('My Staff', Icons.group_rounded),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE4E9F2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name, role, or email',
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
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChipWidget(
                icon: Icons.layers_rounded,
                label: 'All',
                isActive: _selectedFilter == 'All',
                onTap: () => _onFilterChanged('All'),
              ),
              _FilterChipWidget(
                icon: Icons.verified_rounded,
                label: 'Active',
                isActive: _selectedFilter == 'Active',
                onTap: () => _onFilterChanged('Active'),
              ),
              _FilterChipWidget(
                icon: Icons.schedule_rounded,
                label: 'On Leave',
                isActive: _selectedFilter == 'On Leave',
                onTap: () => _onFilterChanged('On Leave'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (_visibleStaff.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4E9F2)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_off_rounded,
                    size: 48,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No staff found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _kBrandNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Try adjusting your search or filter',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF697993),
                    ),
                  ),
                ],
              ),
            )
          else
            ..._visibleStaff.map((staff) => _StaffCard(staff: staff)),
        ],
      ),
    );
  }

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
}

class _StaffCard extends StatelessWidget {
  const _StaffCard({required this.staff});

  final Map<String, String> staff;

  @override
  Widget build(BuildContext context) {
    final statusColor =
        staff['status'] == 'Active'
            ? const Color(0xFF26B377)
            : const Color(0xFFFFB800);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
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
                  shape: BoxShape.circle,
                  gradient: _kBrandGradient,
                ),
                child: Center(
                  child: Text(
                    (staff['name'] ?? 'ST')[0].toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      staff['name'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      staff['role'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF697993),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  staff['status'] ?? 'Unknown',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: staff['email'] ?? '-',
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: staff['phone'] ?? '-',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 16,
                      color: const Color(0xFF8796AF),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Joined',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      staff['joined'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _kBrandNavy,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => _VendorStaffProfilePage(staff: staff),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrandNavy,
                    side: const BorderSide(color: Color(0xFFBDD5FB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 14),
                  label: Text('View', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => _VendorStaffEditorPage(initial: staff),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrandNavy,
                    side: const BorderSide(color: Color(0xFFBDD5FB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: Text('Edit', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VendorStaffProfilePage extends StatelessWidget {
  const _VendorStaffProfilePage({required this.staff});

  final Map<String, String> staff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          'Staff Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: _kBrandGradient,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.24),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (staff['name'] ?? 'S')[0].toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff['name'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        staff['role'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.88),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Column(
              children: [
                _InfoRow(
                  icon: Icons.badge_outlined,
                  label: 'Staff ID',
                  value: staff['id'] ?? '-',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: staff['email'] ?? '-',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: staff['phone'] ?? '-',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Joined',
                  value: staff['joined'] ?? '-',
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.verified_rounded,
                  label: 'Status',
                  value: staff['status'] ?? '-',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorStaffEditorPage extends StatefulWidget {
  const _VendorStaffEditorPage({this.initial});

  final Map<String, String>? initial;

  @override
  State<_VendorStaffEditorPage> createState() => _VendorStaffEditorPageState();
}

class _VendorStaffEditorPageState extends State<_VendorStaffEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _roleController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  String _status = 'Active';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initial?['name'] ?? '',
    );
    _roleController = TextEditingController(
      text: widget.initial?['role'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.initial?['email'] ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.initial?['phone'] ?? '',
    );
    _status = widget.initial?['status'] ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;

    return Scaffold(
      backgroundColor: _kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          isEdit ? 'Edit Staff' : 'Add Staff',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('Name'),
                  const SizedBox(height: 6),
                  _inputField(
                    controller: _nameController,
                    hint: 'Enter staff name',
                  ),
                  const SizedBox(height: 12),
                  _fieldLabel('Role'),
                  const SizedBox(height: 6),
                  _inputField(controller: _roleController, hint: 'Enter role'),
                  const SizedBox(height: 12),
                  _fieldLabel('Email'),
                  const SizedBox(height: 6),
                  _inputField(
                    controller: _emailController,
                    hint: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _fieldLabel('Phone'),
                  const SizedBox(height: 6),
                  _inputField(
                    controller: _phoneController,
                    hint: 'Enter phone number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _fieldLabel('Status'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: _status,
                    items: const [
                      DropdownMenuItem(value: 'Active', child: Text('Active')),
                      DropdownMenuItem(
                        value: 'On Leave',
                        child: Text('On Leave'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _status = value);
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF8FAFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: _kBrandBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kBrandNavy,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() != true) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEdit
                                  ? 'Staff details updated successfully.'
                                  : 'Staff member added successfully.',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        isEdit ? Icons.save_outlined : Icons.person_add_alt_1,
                      ),
                      label: Text(
                        isEdit ? 'Save Changes' : 'Add Staff',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
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

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _kBrandNavy,
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator:
          (value) =>
              (value == null || value.trim().isEmpty) ? 'Required field' : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF8FAFF),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE4E9F2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _kBrandBlue),
        ),
      ),
    );
  }
}

class _ServiceRequestsPage extends StatefulWidget {
  const _ServiceRequestsPage();

  @override
  State<_ServiceRequestsPage> createState() => _ServiceRequestsPageState();
}

class _ServiceRequestsPageState extends State<_ServiceRequestsPage> {
  static const List<Map<String, String>> _seedRequests = [
    {
      'id': 'REQ-2401',
      'title': 'Plumbing Repair',
      'property': 'Building A - Unit 201',
      'priority': 'High',
      'status': 'In Progress',
      'date': '18 Mar 2024',
      'assignee': 'Rajesh Patel',
    },
    {
      'id': 'REQ-2402',
      'title': 'Electrical Maintenance',
      'property': 'Building C - Unit 105',
      'priority': 'Medium',
      'status': 'Pending',
      'date': '17 Mar 2024',
      'assignee': 'Unassigned',
    },
    {
      'id': 'REQ-2403',
      'title': 'AC Servicing',
      'property': 'Building B - Unit 301',
      'priority': 'Low',
      'status': 'Completed',
      'date': '16 Mar 2024',
      'assignee': 'Divya Singh',
    },
    {
      'id': 'REQ-2404',
      'title': 'Window Replacement',
      'property': 'Building A - Unit 405',
      'priority': 'High',
      'status': 'Pending',
      'date': '15 Mar 2024',
      'assignee': 'Unassigned',
    },
  ];

  late List<Map<String, String>> _allRequests;
  late List<Map<String, String>> _visibleRequests;
  String _query = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _allRequests = List<Map<String, String>>.from(_seedRequests);
    _visibleRequests = List<Map<String, String>>.from(_allRequests);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
      _applyFilters();
    });
  }

  void _applyFilters() {
    bool matchesFilter(Map<String, String> item) {
      if (_selectedFilter == 'All') return true;
      return (item['status'] ?? '') == _selectedFilter;
    }

    bool matchesQuery(Map<String, String> item) {
      if (_query.isEmpty) return true;
      return (item['title'] ?? '').toLowerCase().contains(_query) ||
          (item['id'] ?? '').toLowerCase().contains(_query) ||
          (item['property'] ?? '').toLowerCase().contains(_query);
    }

    _visibleRequests =
        _allRequests
            .where((item) => matchesFilter(item) && matchesQuery(item))
            .toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFE74C3C);
      case 'Medium':
        return const Color(0xFFFFB800);
      case 'Low':
        return const Color(0xFF26B377);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return const Color(0xFF26B377);
      case 'In Progress':
        return const Color(0xFF3498DB);
      case 'Pending':
        return const Color(0xFFFFB800);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          24 + kBottomNavigationBarHeight,
        ),
        children: [
          _sectionHeader('Service Requests', Icons.assignment_rounded),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE4E9F2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by title, ID, or property',
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
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChipWidget(
                icon: Icons.layers_rounded,
                label: 'All',
                isActive: _selectedFilter == 'All',
                onTap: () => _onFilterChanged('All'),
              ),
              _FilterChipWidget(
                icon: Icons.schedule_rounded,
                label: 'Pending',
                isActive: _selectedFilter == 'Pending',
                onTap: () => _onFilterChanged('Pending'),
              ),
              _FilterChipWidget(
                icon: Icons.hourglass_bottom_rounded,
                label: 'In Progress',
                isActive: _selectedFilter == 'In Progress',
                onTap: () => _onFilterChanged('In Progress'),
              ),
              _FilterChipWidget(
                icon: Icons.check_circle_rounded,
                label: 'Completed',
                isActive: _selectedFilter == 'Completed',
                onTap: () => _onFilterChanged('Completed'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (_visibleRequests.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4E9F2)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.assignment_returned_rounded,
                    size: 48,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No requests found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _kBrandNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Try adjusting your search or filter',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF697993),
                    ),
                  ),
                ],
              ),
            )
          else
            ..._visibleRequests.map(
              (request) => _RequestCard(
                request: request,
                priorityColor: _getPriorityColor(request['priority'] ?? ''),
                statusColor: _getStatusColor(request['status'] ?? ''),
              ),
            ),
        ],
      ),
    );
  }

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
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.request,
    required this.priorityColor,
    required this.statusColor,
  });

  final Map<String, String> request;
  final Color priorityColor;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4E9F2)),
      ),
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
                  gradient: _kBrandGradient,
                ),
                child: Center(
                  child: Icon(
                    Icons.assignment_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['title'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      request['id'] ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF697993),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  request['status'] ?? 'Unknown',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE4E9F2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.apartment_rounded,
                  label: 'Property',
                  value: request['property'] ?? '-',
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.flag_rounded,
                      size: 16,
                      color: const Color(0xFF8796AF),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Priority',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
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
                        color: priorityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        request['priority'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Assignee',
                  value: request['assignee'] ?? '-',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrandNavy,
                    side: const BorderSide(color: Color(0xFFBDD5FB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 14),
                  label: Text('View', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kBrandNavy,
                    side: const BorderSide(color: Color(0xFFBDD5FB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: Text('Edit', style: GoogleFonts.poppins(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
