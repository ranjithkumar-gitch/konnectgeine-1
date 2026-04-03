import 'package:KonnectGenie/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);
const Color _kCardBorder = Color(0xFFE4E9F2);

class VendorStaffDashboard extends StatefulWidget {
  const VendorStaffDashboard({super.key});

  @override
  State<VendorStaffDashboard> createState() => _VendorStaffDashboardState();
}

class _VendorStaffDashboardState extends State<VendorStaffDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  int get _bottomNavIndex {
    switch (_selectedIndex) {
      case 3:
        return 2;
      case 2:
        return 3;
      default:
        return _selectedIndex;
    }
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex =
          index == 2
              ? 3
              : index == 3
              ? 2
              : index;
    });
  }

  void _selectMenuItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return _StaffHomePage(
          pendingCount: 2,
          acceptedCount: 3,
          completedCount: 12,
        );
      case 1:
        return _AssignedRequestsPage(
          requests: const [
            {
              'id': 'VSR-001',
              'title': 'Plumbing leak in kitchen sink',
              'property': 'Marble Heights, Unit 301',
              'vendor': 'Apex Property Services',
              'priority': 'High',
              'status': 'Pending',
              'assignedOn': '14 Mar 2026',
            },
            {
              'id': 'VSR-002',
              'title': 'AC cooling issue',
              'property': 'City View, Unit 105',
              'vendor': 'Tech Solutions Ltd',
              'priority': 'Medium',
              'status': 'Accepted',
              'assignedOn': '13 Mar 2026',
            },
            {
              'id': 'VSR-003',
              'title': 'Electrical switch board check',
              'property': 'Tech Park Residences, Unit 501',
              'vendor': 'Spark Electrical',
              'priority': 'High',
              'status': 'Completed',
              'assignedOn': '12 Mar 2026',
            },
          ],
          onAccept: (id) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Request $id accepted')));
          },
          onComplete: (id) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Request $id completed')));
          },
        );
      case 2:
        return const _ReportsPage();
      case 3:
        return const _StaffProfilePage();
      default:
        return _StaffHomePage(
          pendingCount: 2,
          acceptedCount: 3,
          completedCount: 12,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
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
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                  children: [
                    _buildSidebarItem(
                      icon: Icons.dashboard_customize_rounded,
                      title: 'Dashboard',
                      isActive: _selectedIndex == 0,
                      onTap: () => _selectMenuItem(0),
                    ),
                    _buildSidebarItem(
                      icon: Icons.handyman_rounded,
                      title: 'Service Requests',
                      isActive: _selectedIndex == 1,
                      onTap: () => _selectMenuItem(1),
                    ),
                    _buildSidebarItem(
                      icon: Icons.account_circle_rounded,
                      title: 'My Profile',
                      isActive: _selectedIndex == 3,
                      onTap: () => _selectMenuItem(3),
                    ),
                    _buildSidebarItem(
                      icon: Icons.fact_check_rounded,
                      title: 'Reports',
                      isActive: _selectedIndex == 2,
                      onTap: () => _selectMenuItem(2),
                    ),
                  ],
                ),
              ),
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
                        'JA',
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
                            'Julie Allen',
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
                            'Vendor Staff',
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
                onTap: _onBottomNavTap,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_rounded),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.handyman_rounded),
                    label: 'Service Requests',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'My Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fact_check_rounded),
                    label: 'Reports',
                  ),
                ],
              ),
            ),
          ),
        ),
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
}

class _StaffHomePage extends StatefulWidget {
  const _StaffHomePage({
    required this.pendingCount,
    required this.acceptedCount,
    required this.completedCount,
  });

  final int pendingCount;
  final int acceptedCount;
  final int completedCount;

  @override
  State<_StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<_StaffHomePage> {
  String _activeTab = 'All';

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

  Widget _kpiCard({
    required String title,
    required int value,
    required String chipLabel,
    required Color chipText,
    required Color chipBg,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3E8F2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
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
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: const Color(0xFF677389),
                  ),
                ),
              ),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '$value',
            style: GoogleFonts.poppins(
              fontSize: 30,
              height: 1,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              chipLabel,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: chipText,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFD8DDE6),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required Color dotColor,
    required String title,
    String? action,
    required Widget child,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3E8F2)),
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
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                if (action != null)
                  Text(
                    action,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2F66DF),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE3E8F2)),
          Padding(padding: contentPadding, child: child),
        ],
      ),
    );
  }

  int _tabCount(String tab) {
    switch (tab) {
      case 'All':
        return widget.pendingCount + widget.acceptedCount;
      case 'New':
        return widget.pendingCount;
      case 'In Progress':
        return widget.acceptedCount;
      case 'Overdue':
        return 0;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 1180;
    final isMedium = screenWidth >= 760;
    final kpiColumns = isWide ? 4 : (isMedium ? 2 : 1);
    final allActive = widget.pendingCount + widget.acceptedCount;
    final completionRate =
        allActive == 0
            ? 0
            : ((widget.completedCount / (widget.completedCount + allActive)) *
                    100)
                .round();

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good afternoon, Julie! 👋',
                    style: GoogleFonts.poppins(
                      fontSize: isMedium ? 22 : 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Color(0xFF26B377),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Live dashboard · Last updated just now',
                          style: GoogleFonts.poppins(
                            fontSize: isMedium ? 13 : 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6B7280),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F5F9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE0E6EE)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _dateLabel(),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFDDF4EB),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF9EE3C6)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBEEDF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF18B278),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Active',
                      style: GoogleFonts.poppins(
                        fontSize: isMedium ? 15 : 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0D7B57),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'You\'re active and can view assigned service requests.',
                      style: GoogleFonts.poppins(
                        fontSize: isMedium ? 12 : 11,
                        color: const Color(0xFF4B5563),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMedium) ...[
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2F66DF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'View Profile',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF374151),
                    side: const BorderSide(color: Color(0xFFD0D7E2)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Service Requests',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: kpiColumns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: isWide ? 1.55 : (isMedium ? 1.45 : 1.85),
          children: [
            _kpiCard(
              title: 'NEW REQUESTS',
              value: widget.pendingCount,
              chipLabel: 'awaiting response',
              chipText: const Color(0xFF18B278),
              chipBg: const Color(0xFFDDF4EB),
              icon: Icons.inbox_rounded,
              iconColor: const Color(0xFF2F66DF),
              iconBg: const Color(0xFFDCE6F9),
            ),
            _kpiCard(
              title: 'IN PROGRESS',
              value: widget.acceptedCount,
              chipLabel: '${widget.acceptedCount} due today',
              chipText: const Color(0xFF4B5563),
              chipBg: const Color(0xFFE6EBF2),
              icon: Icons.settings_rounded,
              iconColor: const Color(0xFFEA9C0B),
              iconBg: const Color(0xFFF8EDDA),
            ),
            _kpiCard(
              title: 'COMPLETED',
              value: widget.completedCount,
              chipLabel: 'total jobs done',
              chipText: const Color(0xFF18B278),
              chipBg: const Color(0xFFDDF4EB),
              icon: Icons.check_circle_rounded,
              iconColor: const Color(0xFF18B278),
              iconBg: const Color(0xFFDDF0E8),
            ),
            _kpiCard(
              title: 'OVERDUE',
              value: 0,
              chipLabel: 'needs attention',
              chipText: const Color(0xFFEF4444),
              chipBg: const Color(0xFFFDE2E2),
              icon: Icons.warning_rounded,
              iconColor: const Color(0xFFEF4444),
              iconBg: const Color(0xFFFDE2E2),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _sectionCard(
                  dotColor: const Color(0xFF2F66DF),
                  title: 'Service Request Trends',
                  action: 'View Report ->',
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.completedCount}',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            Text(
                              'Total Completed',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$completionRate%',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFEA9C0B),
                              ),
                            ),
                            Text(
                              'Completion Rate',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '--',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF18B278),
                              ),
                            ),
                            Text(
                              'Avg Response Time',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _sectionCard(
                  dotColor: const Color(0xFF18B278),
                  title: 'Recent Activity',
                  action: 'All ->',
                  child: Text(
                    'No recent activity.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
            ],
          )
        else ...[
          _sectionCard(
            dotColor: const Color(0xFF2F66DF),
            title: 'Service Request Trends',
            action: 'View Report ->',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.completedCount}',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                Text(
                  'Total Completed',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$completionRate% Completion Rate',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFEA9C0B),
                  ),
                ),
              ],
            ),
          ),
          _sectionCard(
            dotColor: const Color(0xFF18B278),
            title: 'Recent Activity',
            action: 'All ->',
            child: Text(
              'No recent activity.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
        const SizedBox(height: 2),
        _sectionCard(
          dotColor: const Color(0xFFEA9C0B),
          title: 'Active Service Requests',
          action: 'View All ->',
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7EDF6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (final tab in const [
                      'All',
                      'New',
                      'In Progress',
                      'Overdue',
                    ])
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => setState(() => _activeTab = tab),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _activeTab == tab
                                    ? Colors.white
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$tab (${_tabCount(tab)})',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Icon(
                Icons.inbox_rounded,
                size: 30,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(height: 8),
              Text(
                _tabCount(_activeTab) == 0
                    ? 'No service requests yet.'
                    : '${_tabCount(_activeTab)} request(s) available.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2F66DF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'View Service Requests',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        _sectionCard(
          dotColor: const Color(0xFF22A7CC),
          title: 'Performance Score',
          action: 'Based on SRs',
          child: Column(
            children: [
              Text(
                '10/100',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              Text(
                'Overall',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 20),
              _PerformanceMetric(
                icon: Icons.bolt_rounded,
                iconBg: const Color(0xFFDDF4EB),
                iconColor: const Color(0xFF18B278),
                label: 'Response Time',
                progress: 0,
                value: '0%',
                progressColor: const Color(0xFFD8DDE6),
              ),
              const SizedBox(height: 12),
              _PerformanceMetric(
                icon: Icons.verified_rounded,
                iconBg: const Color(0xFFDCE6F9),
                iconColor: const Color(0xFF2F66DF),
                label: 'Job Completion',
                progress: 0,
                value: '0%',
                progressColor: const Color(0xFFD8DDE6),
              ),
              const SizedBox(height: 12),
              _PerformanceMetric(
                icon: Icons.star_rounded,
                iconBg: const Color(0xFFF8EDDA),
                iconColor: const Color(0xFFEA9C0B),
                label: 'Rating',
                progress: 0.95,
                value: '--',
                progressColor: const Color(0xFFEA9C0B),
              ),
              const SizedBox(height: 12),
              _PerformanceMetric(
                icon: Icons.warning_rounded,
                iconBg: const Color(0xFFFDE2E2),
                iconColor: const Color(0xFFEF4444),
                label: 'Overdue Rate',
                progress: 0,
                value: '0%',
                progressColor: const Color(0xFFD8DDE6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PerformanceMetric extends StatelessWidget {
  const _PerformanceMetric({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.progress,
    required this.value,
    required this.progressColor,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final double progress;
  final String value;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFD8DDE6),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 46,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssignedRequestsPage extends StatefulWidget {
  const _AssignedRequestsPage({
    required this.requests,
    required this.onAccept,
    required this.onComplete,
  });

  final List<Map<String, String>> requests;
  final void Function(String id) onAccept;
  final void Function(String id) onComplete;

  @override
  State<_AssignedRequestsPage> createState() => _AssignedRequestsPageState();
}

class _AssignedRequestsPageState extends State<_AssignedRequestsPage> {
  String _search = '';
  String _statusFilter = 'All Status';

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFFFB800);
      case 'Accepted':
        return const Color(0xFF2C5AA0);
      case 'Completed':
        return const Color(0xFF26B377);
      default:
        return Colors.grey;
    }
  }

  String _normalizeStatus(String status) {
    switch (status) {
      case 'Pending':
        return 'New';
      case 'Accepted':
        return 'In Progress';
      case 'Completed':
        return 'Completed';
      default:
        return status;
    }
  }

  String _categoryForTitle(String title) {
    final t = title.toLowerCase();
    if (t.contains('plumb')) return 'Plumbing';
    if (t.contains('ac') || t.contains('cool')) return 'HVAC';
    if (t.contains('elect')) return 'Electrical';
    return 'General';
  }

  int _countByStatus(String status) {
    final statusMap = {
      'New': 'Pending',
      'In Progress': 'Accepted',
      'Completed': 'Completed',
    };
    final targetStatus = statusMap[status] ?? status;
    return widget.requests.where((r) => r['status'] == targetStatus).length;
  }

  List<Map<String, String>> get _visibleRequests {
    final query = _search.trim().toLowerCase();
    return widget.requests.where((r) {
      final statusMatch =
          _statusFilter == 'All Status' ||
          _normalizeStatus(r['status'] ?? '') == _statusFilter;
      final searchMatch =
          query.isEmpty ||
          '${r['id']} ${r['title']} ${r['property']} ${r['vendor']}'
              .toLowerCase()
              .contains(query);
      return statusMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final visible = _visibleRequests;
    final totalCount = widget.requests.length;
    final newCount = _countByStatus('New');
    final inProgressCount = _countByStatus('In Progress');
    final completedCount = _countByStatus('Completed');

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        _PageHeaderBanner(
          title: 'Service Requests',
          subtitle:
              'Manage and track service requests for properties and units',
          icon: Icons.assignment_rounded,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFD8E0EA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: isMobile ? 2 : 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: isMobile ? 1.75 : 1.95,
                children: [
                  _summaryStat(
                    'Total',
                    totalCount,
                    'all requests',
                    Icons.assignment_rounded,
                    const Color(0xFF2F66DF),
                    const Color(0xFFDCE6F9),
                  ),
                  _summaryStat(
                    'New',
                    newCount,
                    'new items',
                    Icons.stars_rounded,
                    const Color(0xFF0EA5E9),
                    const Color(0xFFDDF2FF),
                  ),
                  _summaryStat(
                    'In Progress',
                    inProgressCount,
                    'ongoing',
                    Icons.autorenew_rounded,
                    const Color(0xFFD97706),
                    const Color(0xFFFDF1D8),
                  ),
                  _summaryStat(
                    'Completed',
                    completedCount,
                    'completed',
                    Icons.check_circle_rounded,
                    const Color(0xFF16A34A),
                    const Color(0xFFDFF5E8),
                  ),
                  _summaryStat(
                    'Rejected',
                    0,
                    'declined',
                    Icons.cancel_rounded,
                    const Color(0xFFDC2626),
                    const Color(0xFFFDE2E2),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE4EAF2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child:
                isMobile
                    ? Column(
                      children: [
                        TextField(
                          onChanged: (v) => setState(() => _search = v),
                          decoration: InputDecoration(
                            hintText: 'Search service requests...',
                            prefixIcon: const Icon(Icons.search_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: _kCardBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: _kCardBorder),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _statusFilter,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'All Status',
                                    child: Text('All Status'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'New',
                                    child: Text('New'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'In Progress',
                                    child: Text('In Progress'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Completed',
                                    child: Text('Completed'),
                                  ),
                                ],
                                onChanged:
                                    (v) => setState(
                                      () => _statusFilter = v ?? 'All Status',
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _search = '';
                                  _statusFilter = 'All Status';
                                });
                              },
                              icon: const Icon(Icons.clear_rounded, size: 16),
                              label: const Text('Clear'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(88, 48),
                                side: const BorderSide(color: _kCardBorder),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    : Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            onChanged: (v) => setState(() => _search = v),
                            decoration: InputDecoration(
                              hintText: 'Search service requests...',
                              prefixIcon: const Icon(Icons.search_rounded),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: _kCardBorder,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: _kCardBorder,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: _statusFilter,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'All Status',
                                child: Text('All Status'),
                              ),
                              DropdownMenuItem(
                                value: 'New',
                                child: Text('New'),
                              ),
                              DropdownMenuItem(
                                value: 'In Progress',
                                child: Text('In Progress'),
                              ),
                              DropdownMenuItem(
                                value: 'Completed',
                                child: Text('Completed'),
                              ),
                            ],
                            onChanged:
                                (v) => setState(
                                  () => _statusFilter = v ?? 'All Status',
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _search = '';
                              _statusFilter = 'All Status';
                            });
                          },
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          label: const Text('Clear Filters'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(132, 48),
                            side: const BorderSide(color: _kCardBorder),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ),
        const SizedBox(height: 12),
        if (visible.isEmpty)
          _SectionCard(
            child: Text(
              'No requests found for selected filters.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF5F6C85),
              ),
            ),
          )
        else if (isMobile)
          ...visible.map(
            (request) => _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          request['title'] ?? '-',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      _ReportStatusChip(
                        status: _normalizeStatus(request['status'] ?? ''),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _InfoLine(
                    icon: Icons.tag_rounded,
                    label: 'SR No.',
                    value: request['id'] ?? '-',
                  ),
                  const SizedBox(height: 6),
                  _InfoLine(
                    icon: Icons.category_rounded,
                    label: 'Category',
                    value: _categoryForTitle(request['title'] ?? ''),
                  ),
                  const SizedBox(height: 6),
                  _InfoLine(
                    icon: Icons.business_rounded,
                    label: 'Vendor',
                    value: request['vendor'] ?? '-',
                  ),
                  const SizedBox(height: 6),
                  _InfoLine(
                    icon: Icons.priority_high_rounded,
                    label: 'Priority',
                    value: request['priority'] ?? '-',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const _ReportActionButton(
                        icon: Icons.visibility_rounded,
                        iconColor: Color(0xFF18B278),
                      ),
                      const SizedBox(width: 8),
                      if ((request['status'] ?? '') == 'Pending')
                        Expanded(
                          child: FilledButton(
                            onPressed:
                                () => widget.onAccept(request['id'] ?? ''),
                            style: FilledButton.styleFrom(
                              backgroundColor: _kBrandSecondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Accept'),
                          ),
                        )
                      else if ((request['status'] ?? '') == 'Accepted')
                        Expanded(
                          child: FilledButton(
                            onPressed:
                                () => widget.onComplete(request['id'] ?? ''),
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF16A34A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Complete'),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE4EAF2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 1260),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: const Row(
                        children: [
                          _ReportHeaderCell('SR No.#', width: 140),
                          _ReportHeaderCell('Category', width: 180),
                          _ReportHeaderCell('Service Title', width: 300),
                          _ReportHeaderCell('Scheduled', width: 190),
                          _ReportHeaderCell('Created At', width: 190),
                          _ReportHeaderCell('Status', width: 190),
                          _ReportHeaderCell('Assigned Vendor', width: 220),
                          _ReportHeaderCell('Actions', width: 110),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFE5EAF3)),
                    ...visible.map((request) {
                      final normalized = _normalizeStatus(
                        request['status'] ?? '',
                      );
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE9EDF4),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 140,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9EEFF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFFBFD0F7),
                                  ),
                                ),
                                child: Text(
                                  request['id'] ?? '-',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF3344B5),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            _ReportTextCell(
                              _categoryForTitle(request['title'] ?? ''),
                              width: 180,
                            ),
                            SizedBox(
                              width: 300,
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
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFDF1D8),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      request['priority'] ?? '-',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFB45309),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _ReportTextCell(
                              '${request['assignedOn'] ?? '-'}\n10:00 - 11:30',
                              width: 190,
                            ),
                            _ReportTextCell(
                              '${request['assignedOn'] ?? '-'}\n3:54 PM',
                              width: 190,
                            ),
                            SizedBox(
                              width: 190,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _ReportStatusChip(status: normalized),
                              ),
                            ),
                            _ReportTextCell(
                              request['vendor'] ?? '-',
                              width: 220,
                            ),
                            const SizedBox(
                              width: 110,
                              child: _ReportActionButton(
                                icon: Icons.visibility_rounded,
                                iconColor: Color(0xFF18B278),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _summaryStat(
    String title,
    int count,
    String subtitle,
    IconData icon,
    Color accent,
    Color iconBg,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: accent,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF475569),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: accent,
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

class _ReportsPage extends StatelessWidget {
  const _ReportsPage();

  @override
  Widget build(BuildContext context) {
    const reports = [
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
        'type': 'Property',
        'date': 'Jan 10, 2024',
        'by': 'Test User',
        'size': 'N/A',
        'status': 'Failed',
      },
    ];

    final isMobile = MediaQuery.of(context).size.width < 760;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const _PageHeaderBanner(
          title: 'Reports',
          subtitle: 'View generated reports and manage export actions.',
          icon: Icons.fact_check_rounded,
        ),
        const SizedBox(height: 12),
        if (isMobile)
          ...reports.map(
            (report) => _ReportMobileCard(
              name: report['name'] ?? '-',
              type: report['type'] ?? '-',
              date: report['date'] ?? '-',
              generatedBy: report['by'] ?? '-',
              fileSize: report['size'] ?? '-',
              status: report['status'] ?? '-',
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kCardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 1220),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: const Row(
                        children: [
                          _ReportHeaderCell('Report Name', width: 320),
                          _ReportHeaderCell('Report Type', width: 210),
                          _ReportHeaderCell('Date Generated', width: 210),
                          _ReportHeaderCell('Generated By', width: 230),
                          _ReportHeaderCell('File Size', width: 140),
                          _ReportHeaderCell('Status', width: 220),
                          _ReportHeaderCell('Actions', width: 180),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFE5EAF3)),
                    ...reports.map((report) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE9EDF4),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            _ReportTextCell(report['name'] ?? '-', width: 320),
                            _ReportTextCell(report['type'] ?? '-', width: 210),
                            _ReportTextCell(report['date'] ?? '-', width: 210),
                            _ReportTextCell(report['by'] ?? '-', width: 230),
                            _ReportTextCell(report['size'] ?? '-', width: 140),
                            SizedBox(
                              width: 220,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _ReportStatusChip(
                                  status: report['status'] ?? '',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Row(
                                children: const [
                                  _ReportActionButton(
                                    icon: Icons.visibility_rounded,
                                    iconColor: Color(0xFF18B278),
                                  ),
                                  SizedBox(width: 8),
                                  _ReportActionButton(
                                    icon: Icons.download_rounded,
                                    iconColor: Color(0xFF2F66DF),
                                  ),
                                  SizedBox(width: 8),
                                  _ReportActionButton(
                                    icon: Icons.delete_rounded,
                                    iconColor: Color(0xFFEF4444),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ReportMobileCard extends StatelessWidget {
  const _ReportMobileCard({
    required this.name,
    required this.type,
    required this.date,
    required this.generatedBy,
    required this.fileSize,
    required this.status,
  });

  final String name;
  final String type;
  final String date;
  final String generatedBy;
  final String fileSize;
  final String status;

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kCardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 10),
          _row('Report Type', type),
          _row('Date Generated', date),
          _row('Generated By', generatedBy),
          _row('File Size', fileSize),
          const SizedBox(height: 6),
          _ReportStatusChip(status: status),
          const SizedBox(height: 10),
          Row(
            children: const [
              _ReportActionButton(
                icon: Icons.visibility_rounded,
                iconColor: Color(0xFF18B278),
              ),
              SizedBox(width: 8),
              _ReportActionButton(
                icon: Icons.download_rounded,
                iconColor: Color(0xFF2F66DF),
              ),
              SizedBox(width: 8),
              _ReportActionButton(
                icon: Icons.delete_rounded,
                iconColor: Color(0xFFEF4444),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportHeaderCell extends StatelessWidget {
  const _ReportHeaderCell(this.label, {required this.width});

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF374151),
        ),
      ),
    );
  }
}

class _ReportTextCell extends StatelessWidget {
  const _ReportTextCell(this.text, {required this.width});

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF111827),
        ),
      ),
    );
  }
}

class _ReportStatusChip extends StatelessWidget {
  const _ReportStatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final normalized = status.toLowerCase();
    final bool isReady = normalized == 'ready';
    final bool isProcessing = normalized == 'processing';

    final Color bgColor =
        isReady
            ? const Color(0xFF65B90A)
            : isProcessing
            ? const Color(0xFF2F66DF)
            : const Color(0xFFF6B2B2);
    final Color textColor = Colors.white;
    final IconData icon =
        isReady
            ? Icons.check_circle_rounded
            : isProcessing
            ? Icons.auto_awesome_motion_rounded
            : Icons.error_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 8),
          Text(
            status,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportActionButton extends StatelessWidget {
  const _ReportActionButton({required this.icon, required this.iconColor});

  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDDE3ED)),
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}

class _StaffProfilePage extends StatelessWidget {
  const _StaffProfilePage();

  @override
  Widget build(BuildContext context) {
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
                      'My Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Review your account and work details',
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
        const _StaffProfileSectionCard(
          title: 'Basic User Information',
          children: [
            _StaffProfileReadOnlyField(
              label: 'Staff Name',
              value: 'Julie Allen',
            ),
            _StaffProfileReadOnlyField(
              label: 'Email',
              value: 'julie.staff@konnectproperty.com',
            ),
            _StaffProfileReadOnlyField(
              label: 'Phone Number',
              value: '+91 98765 55555',
            ),
            _StaffProfileReadOnlyField(label: 'Status', value: 'Active'),
          ],
        ),
        const SizedBox(height: 16),
        const _StaffProfileSectionCard(
          title: 'Work Information',
          children: [
            _StaffProfileReadOnlyField(
              label: 'Assigned Vendor',
              value: 'Apex Property Services',
            ),
            _StaffProfileReadOnlyField(label: 'Staff ID', value: 'VS-2026-014'),
            _StaffProfileReadOnlyField(
              label: 'Primary Category',
              value: 'Maintenance & Repair',
            ),
            _StaffProfileReadOnlyField(label: 'Experience', value: '4 Years'),
          ],
        ),
        const SizedBox(height: 16),
        const _StaffProfileSectionCard(
          title: 'Address Information',
          children: [
            _StaffProfileReadOnlyField(label: 'Country', value: 'India'),
            _StaffProfileReadOnlyField(label: 'State', value: 'Telangana'),
            _StaffProfileReadOnlyField(label: 'City', value: 'Hyderabad'),
            _StaffProfileReadOnlyField(
              label: 'ZIP/Postal Code',
              value: '500081',
            ),
          ],
        ),
      ],
    );
  }
}

class _StaffProfileSectionCard extends StatelessWidget {
  const _StaffProfileSectionCard({required this.title, required this.children});

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

class _StaffProfileReadOnlyField extends StatelessWidget {
  const _StaffProfileReadOnlyField({required this.label, required this.value});

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
      margin: const EdgeInsets.only(bottom: 12),
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
    required this.color,
    required this.icon,
  });

  final String title;
  final int count;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF5F6C85),
            ),
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
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive ? _kBrandGradient : null,
          color: isActive ? null : const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive ? Colors.transparent : _kCardBorder,
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

class _InfoLine extends StatelessWidget {
  const _InfoLine({
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
              color: _kBrandSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
