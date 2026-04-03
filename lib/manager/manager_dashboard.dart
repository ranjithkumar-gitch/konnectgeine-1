// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:KonnectGenie/authentication/login_screen.dart';
// import 'manager_properties_page.dart';
// import 'manager_requests_page.dart';
// import 'manager_services_page.dart';
// import 'package:KonnectGenie/manager/Dashboard.dart';
// import 'dart:io';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

// class ManagerDashboard extends StatefulWidget {
//   const ManagerDashboard({super.key});

//   @override
//   State<ManagerDashboard> createState() => _ManagerDashboardState();
// }

// class _ManagerDashboardState extends State<ManagerDashboard> {
//   final _controller = NotchBottomBarController(index: 0);
//   int _selectedIndex = 0;

//   static const List<Widget> _pages = <Widget>[
//     DashboardPage(),
//     ManagerPropertiesPage(),
//     ManagerRequestsPage(),
//     ManagerServicesPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _controller.index = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         bool exitApp = await _showExitDialog(context);
//         return exitApp;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.blueGrey[800],
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           title: const Text(
//             'Konnect @Property',
//             style: TextStyle(color: Colors.white),
//           ),
//           leading: Builder(
//             builder:
//                 (context) => IconButton(
//                   icon: const Icon(Icons.menu, color: Colors.white),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.power_settings_new, color: Colors.white),
//               tooltip: 'Logout',
//               onPressed: () async {
//                 final shouldLogout = await showDialog<bool>(
//                   context: context,
//                   builder:
//                       (context) => AlertDialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         content: Text(
//                           'Are you sure you want to logout?',
//                           style: GoogleFonts.poppins(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: Text(
//                               'Cancel',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.blueAccent,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.of(context).pop(true),
//                             child: Text(
//                               'Logout',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                 );
//                 if (shouldLogout == true) {
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                       builder: (context) => const LoginScreen(),
//                     ),
//                     (route) => false,
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blueGrey[800]),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircleAvatar(
//                       radius: 36,
//                       backgroundImage: NetworkImage(
//                         'https://i.pravatar.cc/150?img=3',
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       "Ranjith",
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "Property Manager",
//                       style: GoogleFonts.poppins(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _buildDrawerItem(Icons.person, "Profile"),
//               _buildDrawerItem(Icons.design_services, "My Services"),
//               _buildDrawerItem(Icons.group, "My Owners"),
//               _buildDrawerItem(Icons.group_add, "My Groups"),
//             ],
//           ),
//         ),
//         body: _pages[_selectedIndex],

//         // ✅ Replaced BottomNavigationBar with AnimatedNotchBottomBar
//         bottomNavigationBar: AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           color: Colors.blueGrey[800]!,
//           showLabel: true,
//           notchColor: Colors.amber,
//           removeMargins: false,
//           bottomBarWidth: 500,
//           durationInMilliSeconds: 300,
//           kIconSize: 26, // ✅ required parameter added
//           kBottomRadius: 28.0, // ✅ required parameter added
//           itemLabelStyle: GoogleFonts.poppins(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//           bottomBarItems: const [
//             BottomBarItem(
//               inActiveItem: Icon(Icons.dashboard, color: Colors.white54),
//               activeItem: Icon(Icons.dashboard, color: Colors.white),
//               itemLabel: 'Dashboard',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(Icons.home_work, color: Colors.white54),
//               activeItem: Icon(Icons.home_work, color: Colors.white),
//               itemLabel: 'Properties',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(Icons.assignment, color: Colors.white54),
//               activeItem: Icon(Icons.assignment, color: Colors.white),
//               itemLabel: 'Requests',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(
//                 Icons.miscellaneous_services,
//                 color: Colors.white54,
//               ),
//               activeItem: Icon(
//                 Icons.miscellaneous_services,
//                 color: Colors.white,
//               ),
//               itemLabel: 'Services',
//             ),
//           ],
//           onTap: _onItemTapped,
//         ),

//         // floatingActionButton: FloatingActionButton(
//         //   backgroundColor: Colors.amber,
//         //   child: const Icon(Icons.add, color: Colors.white),
//         //   onPressed: () {
//         //     // Add FAB logic here
//         //   },
//         // ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }

//   ListTile _buildDrawerItem(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blueGrey[800]),
//       title: Text(title, style: GoogleFonts.poppins()),
//       onTap: () => Navigator.pop(context),
//     );
//   }

//   Future<bool> _showExitDialog(BuildContext context) async {
//     return (await showDialog(
//           context: context,
//           builder:
//               (context) => AlertDialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 content: Text(
//                   'Do you want to exit the app?',
//                   style: GoogleFonts.poppins(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.of(context).pop(false),
//                     child: Text(
//                       'Cancel',
//                       style: GoogleFonts.poppins(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => Navigator.of(context).pop(true),
//                     child: Text(
//                       'Exit',
//                       style: GoogleFonts.poppins(
//                         color: Colors.red,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//         )) ??
//         false;
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KonnectGenie/authentication/login_screen.dart';
import 'manager_properties_page.dart';
import 'manager_requests_page.dart';
import 'manager_services_page.dart';
import 'package:KonnectGenie/manager/Dashboard.dart';
import 'manager_units_page.dart';
import 'manager_users_page.dart';
import 'manager_profile_page.dart';
import 'manager_reports_page.dart';
import 'manager_vendors_page.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedPageIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    ManagerPropertiesPage(),
    ManagerUnitsPage(),
    ManagerUsersPage(),
    ManagerRequestsPage(),
    ManagerServicesPage(),
    ManagerProfilePage(),
    ManagerReportsPage(),
    ManagerVendorsPage(),
  ];

  int get _bottomNavIndex {
    switch (_selectedPageIndex) {
      case 0:
        return 0;
      case 1:
      case 2:
      case 3:
      case 6:
      case 7:
      case 8:
        return 1;
      case 4:
        return 2;
      case 5:
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = switch (index) {
        0 => 0,
        1 => 1,
        2 => 4,
        3 => 5,
        _ => 0,
      };
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
                        isActive: _selectedPageIndex == 0,
                        onTap: () => _onDrawerNavTap(index: 0),
                      ),
                      _buildSidebarItem(
                        icon: Icons.home_rounded,
                        title: 'Properties',
                        isActive: _selectedPageIndex == 1,
                        showTrailingArrow: _selectedPageIndex == 1,
                        onTap: () => _onDrawerNavTap(index: 1),
                      ),
                      _buildSidebarItem(
                        icon: Icons.apartment_rounded,
                        title: 'Units',
                        isActive: _selectedPageIndex == 2,
                        onTap: () => _onDrawerNavTap(index: 2),
                      ),
                      _buildSidebarItem(
                        icon: Icons.groups_rounded,
                        title: 'Users',
                        isActive: _selectedPageIndex == 3,
                        onTap: () => _onDrawerNavTap(index: 3),
                      ),
                      _buildSidebarItem(
                        icon: Icons.handyman_rounded,
                        title: 'Service Requests',
                        isActive: _selectedPageIndex == 4,
                        onTap: () => _onDrawerNavTap(index: 4),
                      ),
                      _buildSidebarItem(
                        icon: Icons.assignment_turned_in_rounded,
                        title: 'My Services',
                        isActive: _selectedPageIndex == 5,
                        onTap: () => _onDrawerNavTap(index: 5),
                      ),
                      _buildSidebarItem(
                        icon: Icons.account_circle_rounded,
                        title: 'My Profile',
                        isActive: _selectedPageIndex == 6,
                        onTap: () => _onDrawerNavTap(index: 6),
                      ),
                      _buildSidebarItem(
                        icon: Icons.summarize_rounded,
                        title: 'Reports',
                        isActive: _selectedPageIndex == 7,
                        onTap: () => _onDrawerNavTap(index: 7),
                      ),
                      _buildSidebarItem(
                        icon: Icons.storefront_rounded,
                        title: 'My Vendors',
                        isActive: _selectedPageIndex == 8,
                        onTap: () => _onDrawerNavTap(index: 8),
                      ),
                    ],
                  ),
                ),
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
                          'KG',
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
                              'Kerry Grushoff',
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
                              'Property Manager',
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
          duration: const Duration(milliseconds: 250),
          child: _pages[_selectedPageIndex],
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
                      icon: Icon(Icons.assignment),
                      label: 'Requests',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.miscellaneous_services),
                      label: 'Services',
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
      _selectedPageIndex = index;
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
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF8893A9),
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
