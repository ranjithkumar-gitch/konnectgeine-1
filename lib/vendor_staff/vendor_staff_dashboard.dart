import 'package:KonnectGenie/authentication/login_screen.dart';
import 'package:flutter/material.dart';
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

  final List<Map<String, String>> _assignedRequests = [
    {
      'id': 'VSR-001',
      'title': 'Plumbing leak in kitchen sink',
      'property': 'Green Heights, Unit 302',
      'vendor': 'Apex Property Services',
      'priority': 'High',
      'status': 'Pending',
      'assignedOn': '18 Mar 2026',
    },
    {
      'id': 'VSR-002',
      'title': 'AC cooling issue',
      'property': 'City View, Unit 105',
      'vendor': 'Apex Property Services',
      'priority': 'Medium',
      'status': 'Accepted',
      'assignedOn': '17 Mar 2026',
    },
    {
      'id': 'VSR-003',
      'title': 'Electrical switch board check',
      'property': 'Skyline Residency, Unit 210',
      'vendor': 'Nova Vendor Group',
      'priority': 'Low',
      'status': 'Completed',
      'assignedOn': '15 Mar 2026',
    },
  ];

  int get _pendingCount =>
      _assignedRequests.where((e) => (e['status'] ?? '') == 'Pending').length;
  int get _acceptedCount =>
      _assignedRequests.where((e) => (e['status'] ?? '') == 'Accepted').length;
  int get _completedCount =>
      _assignedRequests.where((e) => (e['status'] ?? '') == 'Completed').length;

  void _acceptRequest(String id) {
    setState(() {
      final index = _assignedRequests.indexWhere((e) => e['id'] == id);
      if (index == -1) return;
      if (_assignedRequests[index]['status'] == 'Pending') {
        _assignedRequests[index] = {
          ..._assignedRequests[index],
          'status': 'Accepted',
        };
      }
    });
  }

  void _completeRequest(String id) {
    setState(() {
      final index = _assignedRequests.indexWhere((e) => e['id'] == id);
      if (index == -1) return;
      if (_assignedRequests[index]['status'] == 'Accepted') {
        _assignedRequests[index] = {
          ..._assignedRequests[index],
          'status': 'Completed',
        };
      }
    });
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  'Exit app?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),
                content: Text(
                  'Do you want to close Konnect @Property?',
                  style: GoogleFonts.poppins(fontSize: 14),
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
                      backgroundColor: _kBrandSecondary,
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

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _selectMenuItem(int index) {
    Navigator.of(context).pop();
    setState(() => _selectedIndex = index);
  }

  Widget _buildPage() {
    if (_selectedIndex == 0) {
      return _StaffHomePage(
        pendingCount: _pendingCount,
        acceptedCount: _acceptedCount,
        completedCount: _completedCount,
      );
    }
    if (_selectedIndex == 1) {
      return _AssignedRequestsPage(
        requests: _assignedRequests,
        onAccept: _acceptRequest,
        onComplete: _completeRequest,
      );
    }
    if (_selectedIndex == 2) {
      return const _VendorListPage();
    }
    return const _StaffProfilePage();
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
          title: Text(
            'Konnect @Property',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
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
              onPressed: _logout,
              tooltip: 'Logout',
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
                          'https://i.pravatar.cc/150?img=44',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ravi Kumar',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Vendor Staff',
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
                        icon: Icons.dashboard_rounded,
                        title: 'Dashboard',
                        onTap: () => _selectMenuItem(0),
                      ),
                      _buildDrawerItem(
                        icon: Icons.assignment_rounded,
                        title: 'Assigned Requests',
                        onTap: () => _selectMenuItem(1),
                      ),
                      _buildDrawerItem(
                        icon: Icons.business_center_rounded,
                        title: 'Vendor List',
                        onTap: () => _selectMenuItem(2),
                      ),
                      _buildDrawerItem(
                        icon: Icons.person_rounded,
                        title: 'Profile',
                        onTap: () => _selectMenuItem(3),
                      ),
                      const Divider(height: 24),
                      _buildDrawerItem(
                        icon: Icons.logout_rounded,
                        title: 'Logout',
                        onTap: _logout,
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
                  onTap: (index) => setState(() => _selectedIndex = index),
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                  showUnselectedLabels: true,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard_rounded),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assignment_rounded),
                      label: 'Requests',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.business_rounded),
                      label: 'Vendors',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_rounded),
                      label: 'Profile',
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

class _StaffHomePage extends StatelessWidget {
  const _StaffHomePage({
    required this.pendingCount,
    required this.acceptedCount,
    required this.completedCount,
  });

  final int pendingCount;
  final int acceptedCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 360 ? 2 : 3;
    final childAspectRatio =
        crossAxisCount == 2
            ? 1.45
            : screenWidth < 420
            ? 1.12
            : 1.32;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const _PageHeaderBanner(
          title: 'Vendor Staff Dashboard',
          subtitle: 'Accept requests, complete tasks, and track your progress.',
          icon: Icons.handyman_rounded,
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: childAspectRatio,
          children: [
            _InfoCard(
              title: 'Pending',
              count: pendingCount,
              color: const Color(0xFFFFB800),
              icon: Icons.hourglass_bottom_rounded,
            ),
            _InfoCard(
              title: 'Accepted',
              count: acceptedCount,
              color: const Color(0xFF2C5AA0),
              icon: Icons.thumb_up_alt_rounded,
            ),
            _InfoCard(
              title: 'Completed',
              count: completedCount,
              color: const Color(0xFF26B377),
              icon: Icons.check_circle_rounded,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Work Summary',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: _kBrandSecondary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You have $pendingCount new request(s) assigned by vendors. Please accept and complete them on time.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF5F6C85),
                ),
              ),
            ],
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
  String _filter = 'All';

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

  @override
  Widget build(BuildContext context) {
    final visible =
        _filter == 'All'
            ? widget.requests
            : widget.requests.where((r) => r['status'] == _filter).toList();

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const _PageHeaderBanner(
          title: 'Assigned Requests',
          subtitle: 'Accept and complete vendor-assigned service requests.',
          icon: Icons.assignment_rounded,
        ),
        const SizedBox(height: 14),
        _SectionCard(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChip(
                label: 'All',
                isActive: _filter == 'All',
                onTap: () => setState(() => _filter = 'All'),
              ),
              _FilterChip(
                label: 'Pending',
                isActive: _filter == 'Pending',
                onTap: () => setState(() => _filter = 'Pending'),
              ),
              _FilterChip(
                label: 'Accepted',
                isActive: _filter == 'Accepted',
                onTap: () => setState(() => _filter = 'Accepted'),
              ),
              _FilterChip(
                label: 'Completed',
                isActive: _filter == 'Completed',
                onTap: () => setState(() => _filter = 'Completed'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (visible.isEmpty)
          _SectionCard(
            child: Text(
              'No requests found for this status.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF5F6C85),
              ),
            ),
          )
        else
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
                          color: _statusColor(
                            request['status'] ?? '',
                          ).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          request['status'] ?? '-',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _statusColor(request['status'] ?? ''),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _InfoLine(
                    icon: Icons.pin_drop_rounded,
                    label: 'Property',
                    value: request['property'] ?? '-',
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
                  const SizedBox(height: 6),
                  _InfoLine(
                    icon: Icons.calendar_today_rounded,
                    label: 'Assigned On',
                    value: request['assignedOn'] ?? '-',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if ((request['status'] ?? '') == 'Pending')
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _kBrandSecondary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed:
                                () => widget.onAccept(request['id'] ?? ''),
                            icon: const Icon(
                              Icons.thumb_up_alt_rounded,
                              size: 16,
                            ),
                            label: Text(
                              'Accept',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      if ((request['status'] ?? '') == 'Accepted')
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF26B377),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed:
                                () => widget.onComplete(request['id'] ?? ''),
                            icon: const Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                            ),
                            label: Text(
                              'Complete',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      if ((request['status'] ?? '') == 'Completed')
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF26B377),
                              side: const BorderSide(color: Color(0xFFB9E8D2)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.verified_rounded, size: 16),
                            label: Text(
                              'Completed',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _VendorListPage extends StatelessWidget {
  const _VendorListPage();

  @override
  Widget build(BuildContext context) {
    const vendors = [
      {
        'name': 'Apex Property Services',
        'email': 'support@apexvendor.in',
        'phone': '+91 90000 11111',
      },
      {
        'name': 'Nova Vendor Group',
        'email': 'hello@novavendor.in',
        'phone': '+91 90000 22222',
      },
      {
        'name': 'Urban Maintenance Co.',
        'email': 'care@urbanmaint.in',
        'phone': '+91 90000 33333',
      },
    ];

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        const _PageHeaderBanner(
          title: 'Vendor List',
          subtitle: 'Vendors assigning service requests to your staff profile.',
          icon: Icons.business_center_rounded,
        ),
        const SizedBox(height: 12),
        ...vendors.map(
          (vendor) => _SectionCard(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: _kBrandGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.business_rounded,
                    color: Colors.white,
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
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _kBrandSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vendor['email'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
                        ),
                      ),
                      Text(
                        vendor['phone'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF5F6C85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
        const _PageHeaderBanner(
          title: 'Staff Profile',
          subtitle: 'Manage your profile and availability preferences.',
          icon: Icons.person_rounded,
        ),
        const SizedBox(height: 14),
        _SectionCard(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=44',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Ravi Kumar',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _kBrandSecondary,
                ),
              ),
              Text(
                'Vendor Staff',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF5F6C85),
                ),
              ),
              const SizedBox(height: 10),
              const _InfoLine(
                icon: Icons.email_outlined,
                label: 'Email',
                value: 'ravi.staff@konnectproperty.com',
              ),
              const SizedBox(height: 8),
              const _InfoLine(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: '+91 98765 55555',
              ),
            ],
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
