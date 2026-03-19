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
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    ManagerPropertiesPage(),
    ManagerRequestsPage(),
    ManagerServicesPage(),
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
                          'https://i.pravatar.cc/150?img=3',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ranjith',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Property Manager',
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
                        icon: Icons.assignment,
                        title: 'Requests',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.miscellaneous_services,
                        title: 'Services',
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile clicked')),
                          );
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
