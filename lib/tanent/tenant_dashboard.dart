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
  int _selectedIndex = 0;

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
                          'https://i.pravatar.cc/150?img=5',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Raj Kumar',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tenant',
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
                        icon: Icons.apartment,
                        title: 'My Unit',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.payments,
                        title: 'Payments',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.assignment,
                        title: 'Requests',
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
                      icon: Icon(Icons.apartment),
                      label: 'My Unit',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.payments),
                      label: 'Payments',
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
    switch (_selectedIndex) {
      case 0:
        return const _TenantDashboardPage();
      case 1:
        return const _TenantMyUnitPage();
      case 2:
        return const _TenantPaymentsPage();
      case 3:
        return const _TenantRequestsPage();
      default:
        return const _TenantDashboardPage();
    }
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

// Dashboard Page
class _TenantDashboardPage extends StatelessWidget {
  const _TenantDashboardPage();

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
    final isCompact = MediaQuery.of(context).size.width < 380;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const SizedBox(height: 8),
        const _PageHeaderBanner(
          title: 'Tenant Dashboard',
          subtitle:
              'Track your unit, bills, and service requests in one premium view.',
          icon: Icons.dashboard_customize_rounded,
        ),
        const SizedBox(height: 20),
        _sectionHeader('Overview', Icons.analytics_outlined),
        const SizedBox(height: 12),
        _SectionCard(
          child: GridView.count(
            crossAxisCount: isWide ? 4 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio:
                isWide
                    ? 2.2
                    : isCompact
                    ? 1.45
                    : 1.75,
            children: const [
              _InfoCard(
                title: 'Rent Dues',
                count: 2,
                icon: Icons.home_work,
                color: Color(0xFF2C5AA0),
              ),
              _InfoCard(
                title: 'Utility Bills Due',
                count: 3,
                icon: Icons.flash_on,
                color: Color(0xFF0EA5A4),
              ),
              _InfoCard(
                title: 'Open Requests',
                count: 1,
                icon: Icons.assignment,
                color: Color(0xFFF59E0B),
              ),
              _InfoCard(
                title: 'Saved Documents',
                count: 5,
                icon: Icons.description,
                color: Color(0xFF6366F1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sectionHeader('Recent Issues', Icons.warning_outlined),
        const SizedBox(height: 12),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.warning_rounded,
                      color: Color(0xFFF59E0B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Electricity Bill Pending',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Due on 25 Mar 2024',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF697993),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹450',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kBrandSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Pay Now',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sectionHeader('Quick Actions', Icons.bolt_rounded),
        const SizedBox(height: 12),
        _SectionCard(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            children: [
              _ActionButton(
                icon: Icons.payments_rounded,
                label: 'Pay Rent',
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const _PayRentQuickPage(),
                      ),
                    ),
              ),
              _ActionButton(
                icon: Icons.assignment_rounded,
                label: 'Raise Request',
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const _RaiseRequestQuickPage(),
                      ),
                    ),
              ),
              _ActionButton(
                icon: Icons.document_scanner_rounded,
                label: 'Documents',
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const _DocumentsQuickPage(),
                      ),
                    ),
              ),
              _ActionButton(
                icon: Icons.support_agent_rounded,
                label: 'Support',
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const _SupportQuickPage(),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
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
          const _PageHeaderBanner(
            title: 'My Profile',
            subtitle: 'Manage your tenant information and emergency contacts.',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 20),
          _SectionCard(
            child: Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=5',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Raj Kumar',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Tenant',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF697993),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Personal Information',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _ProfileField(label: 'Email', value: 'raj.kumar@email.com'),
          _ProfileField(label: 'Phone', value: '+91 98765 43210'),
          _ProfileField(label: 'Emergency Contact', value: '+91 99876 54321'),
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

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF697993),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kBrandSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
