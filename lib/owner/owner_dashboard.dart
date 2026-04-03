import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KonnectGenie/authentication/login_screen.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List<Widget> get _pages => const [
    _OwnerOverviewPage(),
    _OwnerPropertiesPage(),
    _OwnerUnitsPage(),
    _OwnerMyTenantsPage(),
    _OwnerPropertyManagersPage(),
    _OwnerPaymentsPage(),
    _OwnerServiceRequestsPage(),
    _OwnerReportsPage(),
  ];

  int get _bottomNavIndex {
    switch (_selectedIndex) {
      case 0:
        return 0;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return 1;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = switch (index) {
        0 => 0,
        1 => 1,
        2 => 2,
        3 => 7,
        _ => 0,
      };
    });
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(
                  'Exit App',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),
                content: Text(
                  'Do you want to close the application?',
                  style: GoogleFonts.poppins(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(color: _kBrandSecondary),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kBrandSecondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Exit', style: GoogleFonts.poppins()),
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
            title: Text(
              'Logout',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: GoogleFonts.poppins(),
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _kBrandSecondary,
                  side: const BorderSide(color: Color(0xFFD6E2F5)),
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
    ).push(MaterialPageRoute(builder: (_) => const _OwnerProfilePage()));
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: _kBrandGradient),
          ),
          title: const Text(
            'Konnect @Property',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
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
                  height: 152,
                  padding: const EdgeInsets.fromLTRB(18, 32, 18, 12),
                  decoration: const BoxDecoration(gradient: _kBrandGradient),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/konnect_logo.png',
                            height: 122,
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
                        icon: Icons.speed_rounded,
                        title: 'Dashboard',
                        isActive: _selectedIndex == 0,
                        onTap: () => _onDrawerNavTap(index: 0),
                      ),
                      _buildSidebarItem(
                        icon: Icons.home_rounded,
                        title: 'Properties',
                        isActive: _selectedIndex == 1,
                        onTap: () => _onDrawerNavTap(index: 1),
                      ),
                      _buildSidebarItem(
                        icon: Icons.apartment_rounded,
                        title: 'Units',
                        isActive: _selectedIndex == 2,
                        onTap: () => _onDrawerNavTap(index: 2),
                      ),
                      _buildSidebarItem(
                        icon: Icons.groups_rounded,
                        title: 'My Tenants',
                        isActive: _selectedIndex == 3,
                        onTap: () => _onDrawerNavTap(index: 3),
                      ),
                      _buildSidebarItem(
                        icon: Icons.manage_accounts_rounded,
                        title: 'Property Managers',
                        isActive: _selectedIndex == 4,
                        onTap: () => _onDrawerNavTap(index: 4),
                      ),
                      _buildSidebarItem(
                        icon: Icons.credit_card_rounded,
                        title: 'Payments',
                        isActive: _selectedIndex == 5,
                        onTap: () => _onDrawerNavTap(index: 5),
                      ),
                      _buildSidebarItem(
                        icon: Icons.handyman_rounded,
                        title: 'Service Requests',
                        isActive: _selectedIndex == 6,
                        onTap: () => _onDrawerNavTap(index: 6),
                      ),
                      _buildSidebarItem(
                        icon: Icons.account_circle_rounded,
                        title: 'My Profile',
                        onTap: () {
                          Navigator.pop(context);
                          _openProfilePage();
                        },
                      ),
                      _buildSidebarItem(
                        icon: Icons.summarize_rounded,
                        title: 'Reports',
                        isActive: _selectedIndex == 7,
                        onTap: () => _onDrawerNavTap(index: 7),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                  decoration: const BoxDecoration(color: Color(0xFF0F1A36)),
                  child: Column(
                    children: [
                      Row(
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
                              'EC',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
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
                                  'Emily Carter',
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
                                  'Property Owner',
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
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xFF223157),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _pages[_selectedIndex],
        ),
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
                      icon: Icon(Icons.home_work),
                      label: 'Properties',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.apartment),
                      label: 'Units',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart),
                      label: 'Reports',
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

  void _onDrawerNavTap({required int index}) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
    bool showTrailingArrow = false,
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
                if (showTrailingArrow)
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF8893A9),
                    size: 30,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OwnerOverviewPage extends StatefulWidget {
  const _OwnerOverviewPage();

  @override
  State<_OwnerOverviewPage> createState() => _OwnerOverviewPageState();
}

class _OwnerOverviewPageState extends State<_OwnerOverviewPage> {
  String _selectedRequestFilter = 'All';
  String _searchText = '';

  static const List<Map<String, dynamic>> _kSummary = [
    {
      'label': 'Properties',
      'value': '3',
      'hint': '4 unit(s)',
      'icon': Icons.home_work_rounded,
      'iconBg': Color(0xFFEAF1FB),
      'iconColor': Color(0xFF2C5AA0),
    },
    {
      'label': 'Occupancy',
      'value': '25%',
      'hint': 'Partial',
      'icon': Icons.key_rounded,
      'iconBg': Color(0xFFE7F4EF),
      'iconColor': Color(0xFF0F766E),
    },
    {
      'label': 'Monthly Rent',
      'value': r'$1.1K',
      'hint': 'Collected',
      'icon': Icons.attach_money_rounded,
      'iconBg': Color(0xFFE8F8F7),
      'iconColor': Color(0xFF0D9488),
    },
    {
      'label': 'Service Req.',
      'value': '3',
      'hint': '1 new',
      'icon': Icons.build_circle_outlined,
      'iconBg': Color(0xFFFFF4E7),
      'iconColor': Color(0xFFB45309),
    },
    {
      'label': 'Prop. Managers',
      'value': '1',
      'hint': 'With PM',
      'icon': Icons.manage_accounts_rounded,
      'iconBg': Color(0xFFF1EDFF),
      'iconColor': Color(0xFF6D28D9),
    },
  ];

  static const List<Map<String, String>> _kProperties = [
    {
      'name': 'The Heights',
      'meta': '2 unit(s) - 1 occupied - Cincinnati',
      'income': r'$1,099/mo',
    },
    {
      'name': 'Dallas Avenue Ranch Home',
      'meta': '0 unit(s) - 0 occupied - Madison Heights',
      'income': r'$0/mo',
    },
    {
      'name': 'Stephenson House',
      'meta': '2 unit(s) - 0 occupied - Madison Heights',
      'income': r'$0/mo',
    },
  ];

  static const List<Map<String, String>> _kServiceRequests = [
    {
      'id': 'SR-9',
      'status': 'New',
      'title': 'Window Glass Cleaning',
      'subtitle': 'Madison Heights - Low priority',
      'time': 'Apr 2, 2026 - 09:30 - 10:30',
      'overdue': '1d overdue',
    },
    {
      'id': 'SR-8',
      'status': 'In Progress',
      'title': 'Pipe Replacement Service',
      'subtitle': 'Madison Heights - Medium priority',
      'time': 'Apr 2, 2026 - 10:00 - 11:30',
      'overdue': '1d overdue',
    },
    {
      'id': 'SR-4',
      'status': 'Closed',
      'title': 'Hardwood Floor Replacement',
      'subtitle': 'Madison Heights - Medium priority',
      'time': 'Apr 1, 2026 - 09:40 - 12:40',
      'overdue': '2d overdue',
    },
  ];

  static const List<Map<String, String>> _kRecentActivity = [
    {
      'title': 'New SR submitted',
      'subtitle': 'SR-9 - Window Glass Cleaning - Madison Heights',
      'time': 'Apr 2, 2026 - 3:56 PM',
    },
    {
      'title': 'SR update',
      'subtitle': 'SR-8 - Pipe Replacement Service - Madison Heights',
      'time': 'Apr 2, 2026 - 3:54 PM',
    },
    {
      'title': 'SR completed',
      'subtitle': 'SR-3 - Gas Line Hookup & Inspection - Madison Heights',
      'time': 'Mar 31, 2026 - 10:50 AM',
    },
  ];

  List<Map<String, String>> get _filteredRequests {
    final normalizedSearch = _searchText.trim().toLowerCase();

    return _kServiceRequests.where((request) {
      final status = request['status'] ?? '';
      final matchesFilter =
          _selectedRequestFilter == 'All' || status == _selectedRequestFilter;

      final haystack =
          [
            request['id'] ?? '',
            request['title'] ?? '',
            request['subtitle'] ?? '',
          ].join(' ').toLowerCase();
      final matchesSearch =
          normalizedSearch.isEmpty || haystack.contains(normalizedSearch);

      return matchesFilter && matchesSearch;
    }).toList();
  }

  String _dateTimeText() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final now = DateTime.now();
    final dayName = weekdays[now.weekday - 1];
    final monthName = months[now.month - 1];
    final hour =
        now.hour == 0 ? 12 : (now.hour > 12 ? now.hour - 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    return '$dayName, $monthName ${now.day} - $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final summaryCrossAxisCount =
        width > 900
            ? 5
            : width > 600
            ? 3
            : 2;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, Emily! 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Live dashboard - Last updated just now',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.84),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white,
                          size: 13,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _dateTimeText(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
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
        const SizedBox(height: 16),
        GridView.builder(
          itemCount: _kSummary.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: summaryCrossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 130,
          ),
          itemBuilder: (_, index) {
            final item = _kSummary[index];
            return _OwnerSummaryCard(item: item);
          },
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
              hintText: 'Search by SR ID, service title or location',
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
            _FilterPill(
              icon: Icons.layers_rounded,
              label: 'All',
              isActive: _selectedRequestFilter == 'All',
              onTap: () => setState(() => _selectedRequestFilter = 'All'),
            ),
            _FilterPill(
              icon: Icons.fiber_new_rounded,
              label: 'New',
              isActive: _selectedRequestFilter == 'New',
              onTap: () => setState(() => _selectedRequestFilter = 'New'),
            ),
            _FilterPill(
              icon: Icons.timelapse_rounded,
              label: 'In Progress',
              isActive: _selectedRequestFilter == 'In Progress',
              onTap:
                  () => setState(() => _selectedRequestFilter = 'In Progress'),
            ),
            _FilterPill(
              icon: Icons.verified_rounded,
              label: 'Closed',
              isActive: _selectedRequestFilter == 'Closed',
              onTap: () => setState(() => _selectedRequestFilter = 'Closed'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _OwnerSectionCard(
          title: 'My properties',
          actionText: 'View all',
          child: Column(
            children: [
              ..._kProperties.map((item) => _OwnerPropertyRow(item: item)),
              Row(
                children: const [
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'Total units',
                      value: '4',
                      subtitle: 'units',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'Occupied',
                      value: '1',
                      subtitle: '25% rate',
                      accentColor: Color(0xFF0F766E),
                      background: Color(0xFFEAF7F4),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'Vacant',
                      value: '3',
                      subtitle: 'available',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _OwnerSectionCard(
          title: 'Service requests',
          actionText: 'View all',
          child:
              _filteredRequests.isEmpty
                  ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'No service requests match this filter.',
                      style: GoogleFonts.poppins(
                        color: Colors.blueGrey[500],
                        fontSize: 13,
                      ),
                    ),
                  )
                  : Column(
                    children:
                        _filteredRequests
                            .map((item) => _OwnerServiceRequestRow(item: item))
                            .toList(),
                  ),
        ),
        const SizedBox(height: 14),
        _OwnerSectionCard(
          title: 'PM status',
          actionText: 'Manage',
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'With PM',
                      value: '1',
                      subtitle: 'assigned',
                      accentColor: Color(0xFF0F766E),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'Pay Now',
                      value: '1',
                      subtitle: 'pending',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'Pending',
                      value: '0',
                      subtitle: 'requests',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _OwnerMiniMetric(
                      label: 'No PM',
                      value: '1',
                      subtitle: 'unmanaged',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _OwnerSectionCard(
          title: 'Rent income - 2026',
          actionText: 'Full report',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _legend('Collected', const Color(0xFF0F766E)),
                  const SizedBox(width: 14),
                  _legend('Expected', const Color(0xFFA7F3D0)),
                ],
              ),
              const SizedBox(height: 12),
              const _OwnerIncomeBars(),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _OwnerSectionCard(
          title: 'Recent activity',
          actionText: 'All',
          child: Column(
            children:
                _kRecentActivity
                    .map((item) => _OwnerActivityRow(item: item))
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _legend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF627D98),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _OwnerSummaryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _OwnerSummaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE7F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  (item['label'] as String).toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF829AB1),
                    fontSize: 11,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: item['iconBg'] as Color,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['iconColor'] as Color,
                  size: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            item['value'] as String,
            style: GoogleFonts.poppins(
              fontSize: 30,
              color: const Color(0xFF243B53),
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item['iconBg'] as Color,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              item['hint'] as String,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: item['iconColor'] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerSectionCard extends StatelessWidget {
  final String title;
  final String actionText;
  final Widget child;

  const _OwnerSectionCard({
    required this.title,
    required this.actionText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE7F5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF2C5AA0),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: const Color(0xFF243B53),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  '$actionText ->',
                  style: GoogleFonts.poppins(
                    color: _kBrandPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _OwnerPropertyRow extends StatelessWidget {
  final Map<String, String> item;

  const _OwnerPropertyRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.home_rounded,
              size: 20,
              color: _kBrandPrimary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF243B53),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['meta'] ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF829AB1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['income'] ?? '-',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F766E),
                ),
              ),
              Text(
                'rental income',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF9FB3C8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OwnerServiceRequestRow extends StatelessWidget {
  final Map<String, String> item;

  const _OwnerServiceRequestRow({required this.item});

  Color _statusColor(String status) {
    switch (status) {
      case 'New':
        return const Color(0xFF1D4ED8);
      case 'In Progress':
        return const Color(0xFFB45309);
      case 'Closed':
        return const Color(0xFF0F766E);
      default:
        return const Color(0xFF627D98);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = item['status'] ?? '';
    final statusColor = _statusColor(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _smallTag(
                item['id'] ?? '-',
                const Color(0xFFEAF1FB),
                _kBrandPrimary,
              ),
              _smallTag(status, statusColor.withOpacity(0.14), statusColor),
              _smallTag(
                item['overdue'] ?? '-',
                const Color(0xFFFDECEC),
                const Color(0xFFB91C1C),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item['title'] ?? '-',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF243B53),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['subtitle'] ?? '-',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF829AB1),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 13,
                color: Color(0xFF9FB3C8),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item['time'] ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF829AB1),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF243B53),
                  side: const BorderSide(color: Color(0xFFD1DDF0)),
                  minimumSize: const Size(66, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallTag(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}

class _OwnerMiniMetric extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color accentColor;
  final Color background;

  const _OwnerMiniMetric({
    required this.label,
    required this.value,
    required this.subtitle,
    this.accentColor = const Color(0xFF243B53),
    this.background = const Color(0xFFF3F7FC),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF829AB1),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 30,
              color: accentColor,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF627D98),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerIncomeBars extends StatelessWidget {
  const _OwnerIncomeBars();

  @override
  Widget build(BuildContext context) {
    const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const barColors = [
      Color(0xFF0F766E),
      Color(0xFF0F766E),
      Color(0xFF0F766E),
      Color(0xFF0F766E),
      Color(0xFFA7F3D0),
      Color(0xFFA7F3D0),
    ];

    return SizedBox(
      height: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(labels.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 28,
                height: 120,
                decoration: BoxDecoration(
                  color: barColors[index],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                labels[index],
                style: GoogleFonts.poppins(
                  color: const Color(0xFF829AB1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _OwnerActivityRow extends StatelessWidget {
  final Map<String, String> item;

  const _OwnerActivityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: _kBrandPrimary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF243B53),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['subtitle'] ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF829AB1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['time'] ?? '-',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF627D98),
                    fontWeight: FontWeight.w500,
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

class _OwnerPropertiesPage extends StatefulWidget {
  const _OwnerPropertiesPage();

  @override
  State<_OwnerPropertiesPage> createState() => _OwnerPropertiesPageState();
}

class _OwnerPropertiesPageState extends State<_OwnerPropertiesPage> {
  static const List<Map<String, String>> _seedProperties = [
    {
      'id': '202616',
      'name': 'Kondapur Elite Towers',
      'location': 'Hyderabad',
      'type': 'Apartments/Condo',
      'pm': 'Arjun Mehta',
      'status': 'Active',
    },
    {
      'id': '202615',
      'name': 'Cyber Heights Residency',
      'location': 'Hyderabad',
      'type': 'Apartments/Condo',
      'pm': 'Revanth',
      'status': 'Active',
    },
  ];

  late final List<Map<String, String>> _allProperties;
  late List<Map<String, String>> _visibleProperties;
  String _query = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _allProperties = List<Map<String, String>>.from(_seedProperties);
    _visibleProperties = List<Map<String, String>>.from(_allProperties);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.trim();
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
    final q = _query.toLowerCase();

    bool matchesFilter(Map<String, String> item) {
      switch (_selectedFilter) {
        case 'Active':
          return item['status'] == 'Active';
        case 'Vacant':
          return item['status'] == 'Vacant';
        case 'With PM':
          return (item['pm'] ?? '').trim().isNotEmpty && item['pm'] != 'No PM';
        case 'No PM':
          return (item['pm'] ?? '').trim().isEmpty || item['pm'] == 'No PM';
        default:
          return true;
      }
    }

    bool matchesQuery(Map<String, String> item) {
      if (q.isEmpty) return true;
      final id = (item['id'] ?? '').toLowerCase();
      final name = (item['name'] ?? '').toLowerCase();
      final location = (item['location'] ?? '').toLowerCase();
      return id.contains(q) || name.contains(q) || location.contains(q);
    }

    _visibleProperties =
        _allProperties
            .where((item) => matchesFilter(item) && matchesQuery(item))
            .toList();
  }

  void _handleView(Map<String, String> item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _OwnerPropertyDetailsPage(item: item),
      ),
    );
  }

  Future<void> _handleDelete(Map<String, String> item) async {
    final shouldDelete = await showDialog<bool>(
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
                    Icons.delete_outline_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Delete Property',
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
              'Are you sure you want to delete ${item['name']}? This action cannot be undone.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.35,
                color: const Color(0xFF334E68),
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
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete', style: GoogleFonts.poppins()),
              ),
            ],
          ),
    );

    if (shouldDelete == true) {
      setState(() {
        _allProperties.remove(item);
        _applyFilters();
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Property deleted', style: GoogleFonts.poppins()),
        ),
      );
    }
  }

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
                      'Properties',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your premium property portfolio',
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
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search by property name, city or ID',
              hintStyle: GoogleFonts.poppins(fontSize: 13),
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune_rounded),
                tooltip: 'Advanced filters',
              ),
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
            _FilterPill(
              icon: Icons.layers_rounded,
              label: 'All',
              isActive: _selectedFilter == 'All',
              onTap: () => _onFilterChanged('All'),
            ),
            _FilterPill(
              icon: Icons.verified_rounded,
              label: 'Active',
              isActive: _selectedFilter == 'Active',
              onTap: () => _onFilterChanged('Active'),
            ),
            _FilterPill(
              icon: Icons.meeting_room_rounded,
              label: 'Vacant',
              isActive: _selectedFilter == 'Vacant',
              onTap: () => _onFilterChanged('Vacant'),
            ),
            _FilterPill(
              icon: Icons.person_outline_rounded,
              label: 'With PM',
              isActive: _selectedFilter == 'With PM',
              onTap: () => _onFilterChanged('With PM'),
            ),
            _FilterPill(
              icon: Icons.block_rounded,
              label: 'No PM',
              isActive: _selectedFilter == 'No PM',
              onTap: () => _onFilterChanged('No PM'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        if (_visibleProperties.isEmpty)
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
          ..._visibleProperties.map(
            (item) => _PropertyItemCard(
              item: item,
              onView: () => _handleView(item),
              onDelete: () => _handleDelete(item),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _PropertyItemCard extends StatelessWidget {
  final Map<String, String> item;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const _PropertyItemCard({
    required this.item,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = item['status'] == 'Active' ? Colors.green : Colors.grey;

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
                        item['name']!,
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
                          _PropertyQuickTag(text: 'ID ${item['id']!}'),
                          _PropertyQuickTag(text: item['type']!),
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
                    label: 'Location',
                    value: item['location']!,
                  ),
                  _PropertyDetailRow(
                    icon: Icons.person_outline,
                    label: 'PM Status',
                    value: item['pm']!,
                  ),
                  const _PropertyDetailRow(
                    icon: Icons.king_bed_outlined,
                    label: 'Occupancy',
                    value: '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(label: item['status']!, color: statusColor),
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
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade100),
                    foregroundColor: Colors.red.shade600,
                  ),
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  label: Text(
                    'Delete',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
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

class _OwnerPropertyDetailsPage extends StatelessWidget {
  final Map<String, String> item;

  const _OwnerPropertyDetailsPage({required this.item});

  @override
  Widget build(BuildContext context) {
    final statusColor = item['status'] == 'Active' ? Colors.green : Colors.grey;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          item['name'] ?? 'Property Details',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
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
                        'Property Insights',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Premium overview of this property profile',
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
          Card(
            elevation: 0,
            color: Colors.white,
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
                              item['name'] ?? 'Property',
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
                                _PropertyQuickTag(
                                  text: 'ID ${item['id'] ?? '-'}',
                                ),
                                _PropertyQuickTag(text: item['type'] ?? '-'),
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
                          label: 'Location',
                          value: item['location'] ?? '-',
                        ),
                        _PropertyDetailRow(
                          icon: Icons.apartment_rounded,
                          label: 'Type',
                          value: item['type'] ?? '-',
                        ),
                        _PropertyDetailRow(
                          icon: Icons.person_outline,
                          label: 'PM',
                          value: item['pm'] ?? '-',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _StatusChip(
                        label: item['status'] ?? 'Unknown',
                        color: statusColor,
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.blueGrey.shade100),
                          foregroundColor: const Color(0xFF243B53),
                        ),
                        icon: const Icon(Icons.arrow_back_rounded, size: 18),
                        label: Text(
                          'Back',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                    ],
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

class _OwnerUnitsPage extends StatefulWidget {
  const _OwnerUnitsPage();

  @override
  State<_OwnerUnitsPage> createState() => _OwnerUnitsPageState();
}

class _OwnerUnitsPageState extends State<_OwnerUnitsPage> {
  static const List<Map<String, String>> _seedUnits = [
    {
      'id': 'U202613',
      'property': 'Kondapur Elite Towers',
      'unitNo': 'D-402',
      'tenant': 'No tenant',
      'occupancy': 'Vacant for Rent',
      'manager': 'Arjun Mehta',
      'status': 'Active',
    },
    {
      'id': 'U202612',
      'property': 'Kondapur Elite Towers',
      'unitNo': 'B-203',
      'tenant': 'No tenant',
      'occupancy': 'Vacant for Rent',
      'manager': 'Arjun Mehta',
      'status': 'Active',
    },
    {
      'id': 'U202611',
      'property': 'Cyber Heights Residency',
      'unitNo': 'A-101',
      'tenant': 'Owner Occupied',
      'occupancy': 'Self Occupied',
      'manager': 'Revanth',
      'status': 'Active',
    },
  ];

  late final List<Map<String, String>> _allUnits;
  late List<Map<String, String>> _visibleUnits;
  String _query = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _allUnits = List<Map<String, String>>.from(_seedUnits);
    _visibleUnits = List<Map<String, String>>.from(_allUnits);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _onFilterChanged(String value) {
    setState(() {
      _selectedFilter = value;
      _applyFilters();
    });
  }

  void _applyFilters() {
    bool matchesFilter(Map<String, String> item) {
      switch (_selectedFilter) {
        case 'Active':
          return item['status'] == 'Active';
        case 'Vacant':
          return item['occupancy'] == 'Vacant for Rent';
        case 'Occupied':
          return item['occupancy'] == 'Self Occupied';
        default:
          return true;
      }
    }

    bool matchesQuery(Map<String, String> item) {
      if (_query.isEmpty) return true;
      return (item['id'] ?? '').toLowerCase().contains(_query) ||
          (item['property'] ?? '').toLowerCase().contains(_query) ||
          (item['tenant'] ?? '').toLowerCase().contains(_query);
    }

    _visibleUnits =
        _allUnits
            .where((item) => matchesFilter(item) && matchesQuery(item))
            .toList();
  }

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
                      'Units',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your property units',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.84),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.14),
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
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search by unit ID, property, tenant',
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
            _FilterPill(
              icon: Icons.layers_rounded,
              label: 'All',
              isActive: _selectedFilter == 'All',
              onTap: () => _onFilterChanged('All'),
            ),
            _FilterPill(
              icon: Icons.verified_rounded,
              label: 'Active',
              isActive: _selectedFilter == 'Active',
              onTap: () => _onFilterChanged('Active'),
            ),
            _FilterPill(
              icon: Icons.key_rounded,
              label: 'Vacant',
              isActive: _selectedFilter == 'Vacant',
              onTap: () => _onFilterChanged('Vacant'),
            ),
            _FilterPill(
              icon: Icons.home_rounded,
              label: 'Occupied',
              isActive: _selectedFilter == 'Occupied',
              onTap: () => _onFilterChanged('Occupied'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        if (_visibleUnits.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
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
          ..._visibleUnits.map((item) => _UnitItemCard(item: item)),
      ],
    );
  }
}

class _UnitItemCard extends StatelessWidget {
  final Map<String, String> item;

  const _UnitItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final occupancy = item['occupancy'] ?? '-';
    final occupancyColor =
        occupancy == 'Self Occupied' ? Colors.blue : Colors.deepPurple;

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
                _PropertyQuickTag(text: item['id'] ?? '-'),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['property'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _PropertyQuickTag(text: 'Unit ${item['unitNo'] ?? '-'}'),
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
                    icon: Icons.person_outline,
                    label: 'Tenant',
                    value: item['tenant'] ?? '-',
                  ),
                  _PropertyDetailRow(
                    icon: Icons.badge_outlined,
                    label: 'Manager',
                    value: item['manager'] ?? '-',
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        size: 16,
                        color: Colors.blueGrey[400],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Occupancy',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      _StatusChip(label: occupancy, color: occupancyColor),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(
                  label: item['status'] ?? 'Active',
                  color: Colors.green,
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blueGrey.shade100),
                    foregroundColor: _kBrandSecondary,
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

class _OwnerMyTenantsPage extends StatelessWidget {
  const _OwnerMyTenantsPage();

  static const List<Map<String, String>> _tenants = [
    {
      'id': 'T-1001',
      'name': 'Olivia Martin',
      'secondary': 'Unit D-402',
      'tag1': 'Lease Active',
      'tag2': 'Premium',
      'detail1': 'Kondapur Elite Towers',
      'detail2': '+1 248 555 1188',
      'status': 'Active',
    },
    {
      'id': 'T-1002',
      'name': 'Noah Smith',
      'secondary': 'Unit B-203',
      'tag1': 'Lease Renewal',
      'tag2': 'Due Soon',
      'detail1': 'Kondapur Elite Towers',
      'detail2': '+1 248 555 2233',
      'status': 'Pending',
    },
    {
      'id': 'T-1003',
      'name': 'Emma Johnson',
      'secondary': 'Unit A-101',
      'tag1': 'Self Occupied',
      'tag2': 'Owner',
      'detail1': 'Cyber Heights Residency',
      'detail2': '+1 248 555 7711',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _OwnerModulePage(
      title: 'My Tenants',
      subtitle: 'Track tenant profiles, leases and occupancy status',
      heroIcon: Icons.groups_rounded,
      searchHint: 'Search by tenant name, unit or ID',
      filters: ['All', 'Active', 'Pending'],
      items: _tenants,
      primaryKey: 'name',
      secondaryKey: 'secondary',
      leadingTagKey: 'id',
      trailingTagKey: 'tag1',
      detailOneLabel: 'Property',
      detailOneKey: 'detail1',
      detailTwoLabel: 'Phone',
      detailTwoKey: 'detail2',
      statusKey: 'status',
    );
  }
}

class _OwnerPropertyManagersPage extends StatelessWidget {
  const _OwnerPropertyManagersPage();

  static const List<Map<String, String>> _managers = [
    {
      'id': 'PM-201',
      'name': 'Arjun Mehta',
      'secondary': 'Senior Property Manager',
      'tag1': '3 Properties',
      'tag2': 'Top Rated',
      'detail1': 'arjun.mehta@konnect.com',
      'detail2': '+1 248 555 8833',
      'status': 'Active',
    },
    {
      'id': 'PM-202',
      'name': 'Revanth Kumar',
      'secondary': 'Assistant Property Manager',
      'tag1': '1 Property',
      'tag2': 'Onboarding',
      'detail1': 'revanth@konnect.com',
      'detail2': '+1 248 555 9912',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _OwnerModulePage(
      title: 'Property Managers',
      subtitle: 'Manage assigned managers and performance snapshots',
      heroIcon: Icons.manage_accounts_rounded,
      searchHint: 'Search by manager name or email',
      filters: ['All', 'Active', 'Pending'],
      items: _managers,
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

class _OwnerPaymentsPage extends StatelessWidget {
  const _OwnerPaymentsPage();

  static const List<Map<String, String>> _payments = [
    {
      'id': 'PAY-771',
      'name': 'Rent Collection - April',
      'secondary': r'$1,099.00',
      'tag1': 'The Heights',
      'tag2': 'Collected',
      'detail1': 'Apr 03, 2026',
      'detail2': 'Bank Transfer',
      'status': 'Paid',
    },
    {
      'id': 'PAY-772',
      'name': 'Service Invoice - Plumbing',
      'secondary': r'$240.00',
      'tag1': 'Kondapur Elite Towers',
      'tag2': 'Vendor Bill',
      'detail1': 'Apr 06, 2026',
      'detail2': 'Card Payment',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _OwnerModulePage(
      title: 'Payments',
      subtitle: 'Review rent collections, invoices and payout statuses',
      heroIcon: Icons.credit_card_rounded,
      searchHint: 'Search by payment ID, title or property',
      filters: ['All', 'Paid', 'Pending'],
      items: _payments,
      primaryKey: 'name',
      secondaryKey: 'secondary',
      leadingTagKey: 'id',
      trailingTagKey: 'tag1',
      detailOneLabel: 'Due Date',
      detailOneKey: 'detail1',
      detailTwoLabel: 'Method',
      detailTwoKey: 'detail2',
      statusKey: 'status',
    );
  }
}

class _OwnerServiceRequestsPage extends StatelessWidget {
  const _OwnerServiceRequestsPage();

  static const List<Map<String, String>> _requests = [
    {
      'id': 'SR-9',
      'name': 'Window Glass Cleaning',
      'secondary': 'Low priority',
      'tag1': 'Madison Heights',
      'tag2': '1d overdue',
      'detail1': 'Apr 2, 2026 - 09:30 - 10:30',
      'detail2': 'Assigned to: Arjun Mehta',
      'status': 'New',
    },
    {
      'id': 'SR-8',
      'name': 'Pipe Replacement Service',
      'secondary': 'Medium priority',
      'tag1': 'Madison Heights',
      'tag2': 'In Progress',
      'detail1': 'Apr 2, 2026 - 10:00 - 11:30',
      'detail2': 'Assigned to: Revanth Kumar',
      'status': 'In Progress',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return const _OwnerModulePage(
      title: 'Service Requests',
      subtitle: 'Monitor maintenance requests and closure progress',
      heroIcon: Icons.handyman_rounded,
      searchHint: 'Search by service request ID or title',
      filters: ['All', 'New', 'In Progress', 'Closed'],
      items: _requests,
      primaryKey: 'name',
      secondaryKey: 'secondary',
      leadingTagKey: 'id',
      trailingTagKey: 'tag1',
      detailOneLabel: 'Schedule',
      detailOneKey: 'detail1',
      detailTwoLabel: 'Assignee',
      detailTwoKey: 'detail2',
      statusKey: 'status',
    );
  }
}

class _OwnerModulePage extends StatefulWidget {
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

  const _OwnerModulePage({
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
  State<_OwnerModulePage> createState() => _OwnerModulePageState();
}

class _OwnerModulePageState extends State<_OwnerModulePage> {
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
      case 'Closed':
        return const Color(0xFF0F766E);
      case 'Pending':
      case 'In Progress':
        return const Color(0xFFB45309);
      case 'New':
        return const Color(0xFF1D4ED8);
      default:
        return Colors.blueGrey;
    }
  }

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
            onChanged: (value) => setState(() => _query = value),
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
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children:
              widget.filters
                  .map(
                    (filter) => _FilterPill(
                      icon:
                          filter == 'All'
                              ? Icons.layers_rounded
                              : Icons.tune_rounded,
                      label: filter,
                      isActive: _selectedFilter == filter,
                      onTap: () => setState(() => _selectedFilter = filter),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 18),
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
                                  _PropertyQuickTag(
                                    text: item[widget.leadingTagKey] ?? '-',
                                  ),
                                  _PropertyQuickTag(
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
                          _PropertyDetailRow(
                            icon: Icons.info_outline_rounded,
                            label: widget.detailOneLabel,
                            value: item[widget.detailOneKey] ?? '-',
                          ),
                          _PropertyDetailRow(
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
                        _StatusChip(label: status, color: statusColor),
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

class _OwnerReportsPage extends StatefulWidget {
  const _OwnerReportsPage();

  @override
  State<_OwnerReportsPage> createState() => _OwnerReportsPageState();
}

class _OwnerReportsPageState extends State<_OwnerReportsPage> {
  static const List<Map<String, String>> _seedReports = [
    {
      'name': 'Property List Report',
      'type': 'Property',
      'date': '1/15/24, 5:30 AM',
      'size': '2.5 MB',
      'status': 'Ready',
      'by': 'John Doe',
    },
    {
      'name': 'Service Requests Summary',
      'type': 'Service Request',
      'date': '1/14/24, 5:30 AM',
      'size': '1.8 MB',
      'status': 'Ready',
      'by': 'Jane Smith',
    },
    {
      'name': 'Monthly Analytics',
      'type': 'Analytics',
      'date': '1/12/24, 5:30 AM',
      'size': '3.2 MB',
      'status': 'Processing',
      'by': 'System',
    },
  ];

  late final List<Map<String, String>> _allReports;
  late List<Map<String, String>> _visibleReports;
  String _query = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _allReports = List<Map<String, String>>.from(_seedReports);
    _visibleReports = List<Map<String, String>>.from(_allReports);
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _onFilterChanged(String value) {
    setState(() {
      _selectedFilter = value;
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
          (item['type'] ?? '').toLowerCase().contains(_query);
    }

    _visibleReports =
        _allReports
            .where((item) => matchesFilter(item) && matchesQuery(item))
            .toList();
  }

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
                      'Reports',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Track and download your key reports',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.84),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bar_chart_rounded, color: Colors.white),
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
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search reports',
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
            _FilterPill(
              icon: Icons.layers_rounded,
              label: 'All',
              isActive: _selectedFilter == 'All',
              onTap: () => _onFilterChanged('All'),
            ),
            _FilterPill(
              icon: Icons.check_circle_outline,
              label: 'Ready',
              isActive: _selectedFilter == 'Ready',
              onTap: () => _onFilterChanged('Ready'),
            ),
            _FilterPill(
              icon: Icons.hourglass_top_rounded,
              label: 'Processing',
              isActive: _selectedFilter == 'Processing',
              onTap: () => _onFilterChanged('Processing'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        if (_visibleReports.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
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
          ..._visibleReports.map((item) => _ReportItemCard(item: item)),
      ],
    );
  }
}

class _ReportItemCard extends StatelessWidget {
  final Map<String, String> item;

  const _ReportItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final status = item['status'] ?? 'Ready';
    final statusColor = status == 'Processing' ? Colors.blue : Colors.green;

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
                        item['name'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _PropertyQuickTag(text: item['type'] ?? '-'),
                          _PropertyQuickTag(text: item['size'] ?? '-'),
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
                    icon: Icons.schedule_rounded,
                    label: 'Date Generated',
                    value: item['date'] ?? '-',
                  ),
                  _PropertyDetailRow(
                    icon: Icons.person_outline,
                    label: 'Generated By',
                    value: item['by'] ?? '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _StatusChip(label: status, color: statusColor),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blueGrey.shade100),
                    foregroundColor: _kBrandSecondary,
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: Text('View', style: GoogleFonts.poppins(fontSize: 12)),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade100),
                    foregroundColor: Colors.blue.shade600,
                  ),
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: Text(
                    'Download',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnerProfilePage extends StatelessWidget {
  const _OwnerProfilePage();

  Widget _sectionTitle(String text, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF4FD), Color(0xFFF7FAFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE7F9)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: _kBrandSecondary),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF243B53),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    String initialValue,
    String hint, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label, required: required),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FBFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey.shade100),
          ),
          child: Text(
            initialValue.isEmpty ? '-' : initialValue,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF334155),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        required ? '$text *' : text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width > 980;
    final bool isTablet = width > 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -90,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _kBrandPrimary.withOpacity(0.10),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _kBrandSecondary.withOpacity(0.08),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: _kBrandGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _kBrandSecondary.withOpacity(0.30),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Wrap(
                  runSpacing: 14,
                  spacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 44,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isWide ? 360 : (isTablet ? 320 : 260),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sahib Oberoi',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Owner Dashboard Profile',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.16),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.home_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Owner',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFDDE7F5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Profile Information', Icons.badge_outlined),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _field(
                          'Full Name',
                          'Sahib Oberoi',
                          'Full Name',
                          required: true,
                        ),
                        const SizedBox(height: 12),
                        _field(
                          'Email',
                          'sahib.oberoi@sunkpo.com',
                          'Email',
                          required: true,
                        ),
                        const SizedBox(height: 12),
                        _field('Phone Number', '9845679056', 'Phone Number'),
                        const SizedBox(height: 12),
                        _field('Status', 'Active', 'Status', required: true),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFDDE7F5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      'Address Information',
                      Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _field('Country', 'India', 'Country'),
                        const SizedBox(height: 12),
                        _field('State/Province', 'Telangana', 'State/Province'),
                        const SizedBox(height: 12),
                        _field('City', 'Hyderabad', 'City'),
                        const SizedBox(height: 12),
                        _field('ZIP/Postal Code', '500068', 'ZIP/Postal Code'),
                        const SizedBox(height: 12),
                        _field('Street Address', '', 'Enter street address'),
                        const SizedBox(height: 12),
                        _field(
                          'Notes',
                          '',
                          'Enter any additional notes',
                          maxLines: 3,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            backgroundColor: _kBrandSecondary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Close',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
