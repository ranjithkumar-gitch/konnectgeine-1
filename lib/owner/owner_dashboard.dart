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

  static const List<Widget> _pages = <Widget>[
    _OwnerOverviewPage(),
    _OwnerPropertiesPage(),
    _OwnerUnitsPage(),
    _OwnerReportsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                        color: const Color(0xFF098EDD),
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
                        color: const Color(0xFF098EDD),
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
                          'https://i.pravatar.cc/150?img=12',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sahib Oberoi',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Property Owner',
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
                    children: [
                      _buildDrawerItem(
                        icon: Icons.dashboard,
                        title: 'Dashboard',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.home_work,
                        title: 'Properties',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.apartment,
                        title: 'Units',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.bar_chart,
                        title: 'Reports',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 3;
                          });
                        },
                      ),
                      const Divider(),
                      _buildDrawerItem(
                        icon: Icons.person,
                        title: 'My Profile',
                        onTap: () {
                          Navigator.pop(context);
                          _openProfilePage();
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Settings clicked')),
                          );
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          Navigator.pop(context);
                          _logout();
                        },
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
                  currentIndex: _selectedIndex,
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: _kBrandSecondary),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: onTap,
    );
  }
}

class _OwnerOverviewPage extends StatelessWidget {
  const _OwnerOverviewPage();

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
    final isWide = MediaQuery.of(context).size.width > 600;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        // Container(
        //   padding: const EdgeInsets.all(18),
        //   decoration: BoxDecoration(
        //     gradient: _kBrandGradient,
        //     borderRadius: BorderRadius.circular(20),
        //     boxShadow: [
        //       BoxShadow(
        //         color: _kBrandSecondary.withOpacity(0.22),
        //         blurRadius: 18,
        //         offset: const Offset(0, 8),
        //       ),
        //     ],
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Owner Dashboard',
        //               style: GoogleFonts.poppins(
        //                 fontSize: 24,
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //             const SizedBox(height: 6),
        //             Text(
        //               'Track all your properties, units, tenants and reports in one place.',
        //               style: GoogleFonts.poppins(
        //                 fontSize: 13,
        //                 color: Colors.white.withOpacity(0.84),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: 48,
        //         height: 48,
        //         decoration: BoxDecoration(
        //           color: Colors.white.withOpacity(0.16),
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: const Icon(
        //           Icons.dashboard_customize,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 20),
        _sectionHeader('All Information', Icons.apps_rounded),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: isWide ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          children: const [
            _InfoCard(
              title: 'Properties',
              count: 2,
              icon: Icons.home_work,
              color: Colors.blue,
            ),
            _InfoCard(
              title: 'Units',
              count: 3,
              icon: Icons.apartment,
              color: Colors.green,
            ),
            _InfoCard(
              title: 'Tenants',
              count: 0,
              icon: Icons.person,
              color: Colors.orange,
            ),
            _InfoCard(
              title: 'Vendors',
              count: 0,
              icon: Icons.handyman,
              color: Colors.purple,
            ),
          ],
        ),

        const SizedBox(height: 24),

        _sectionHeader('Overview', Icons.analytics_outlined),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: isWide ? 3 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.6,
          children: const [
            _InfoCard(
              title: 'PMs',
              count: 2,
              icon: Icons.group,
              color: Colors.blue,
            ),
            _InfoCard(
              title: 'My Tenants',
              count: 0,
              icon: Icons.key,
              color: Colors.deepPurple,
            ),
            _InfoCard(
              title: 'Vendors',
              count: 0,
              icon: Icons.build,
              color: Colors.teal,
            ),
          ],
        ),

        const SizedBox(height: 24),

        _sectionHeader('PM Status', Icons.manage_accounts_outlined),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: isWide ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          children: const [
            _InfoCard(
              title: 'With PM',
              count: 2,
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            _InfoCard(
              title: 'Pay Now',
              count: 0,
              icon: Icons.credit_card,
              color: Colors.orange,
            ),
            _InfoCard(
              title: 'Pending',
              count: 0,
              icon: Icons.pending,
              color: Colors.amber,
            ),
            _InfoCard(
              title: 'No PM',
              count: 0,
              icon: Icons.block,
              color: Colors.blue,
            ),
          ],
        ),

        const SizedBox(height: 24),

        _sectionHeader(
          'Service Requests',
          Icons.miscellaneous_services_outlined,
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: isWide ? 4 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          children: const [
            _InfoCard(
              title: 'New SR',
              count: 0,
              icon: Icons.schedule,
              color: Colors.blue,
            ),
            _InfoCard(
              title: 'In Progress SR',
              count: 0,
              icon: Icons.work,
              color: Colors.orange,
            ),
            _InfoCard(
              title: 'Closed SR',
              count: 1,
              icon: Icons.check,
              color: Colors.green,
            ),
            _InfoCard(
              title: 'Rejected SR',
              count: 0,
              icon: Icons.close,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
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

class _InfoCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const _InfoCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: _kBrandPrimary.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$count',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
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
