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
import 'dart:io';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:kf_drawer/kf_drawer.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard>
    with TickerProviderStateMixin {
  late KFDrawerController _drawerController;
  final NotchBottomBarController _notchController = NotchBottomBarController(
    index: 0,
  );

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    ManagerPropertiesPage(),
    ManagerRequestsPage(),
    ManagerServicesPage(),
  ];

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: _buildMainScaffold(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text(
            'Profile',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          icon: const Icon(Icons.person, color: Colors.white),
          page: _buildMainScaffold(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'My Services',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          icon: const Icon(Icons.design_services, color: Colors.white),
          page: _buildMainScaffold(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'My Owners',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          icon: const Icon(Icons.group, color: Colors.white),
          page: _buildMainScaffold(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'My Groups',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          icon: const Icon(Icons.group_add, color: Colors.white),
          page: _buildMainScaffold(),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _notchController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KFDrawer(
      controller: _drawerController,
      decoration: BoxDecoration(color: Colors.blueGrey[800]),
      borderRadius: 24.0,
      shadowBorderRadius: 20.0,
      animationDuration: const Duration(milliseconds: 250),
      header: _buildDrawerHeader(),
    );
  }

  Widget _buildDrawerHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            const SizedBox(height: 12),
            Text(
              "Ranjith",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              "Property Manager",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24, thickness: 1),
          ],
        ),
      ),
    );
  }

  /// ✅ This Scaffold contains your AppBar, BottomBar, and dynamic body
  Widget _buildMainScaffold() {
    return StatefulBuilder(
      builder: (context, setStateInner) {
        return WillPopScope(
          onWillPop: () async => await _showExitDialog(context),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[800],
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                'Konnect @Property',
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _drawerController.toggle!(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                  tooltip: 'Logout',
                  onPressed: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Text(
                              'Are you sure you want to logout?',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: Text(
                                  'Logout',
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    );
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

            // ✅ Dynamically change pages
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_selectedIndex],
            ),

            bottomNavigationBar: AnimatedNotchBottomBar(
              notchBottomBarController: _notchController,
              color: Colors.blueGrey[800]!,
              showLabel: true,
              notchColor: Colors.orange,
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
                  inActiveItem: Icon(Icons.dashboard, color: Colors.white54),
                  activeItem: Icon(Icons.dashboard, color: Colors.white),
                  itemLabel: 'Dashboard',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.home_work, color: Colors.white54),
                  activeItem: Icon(Icons.home_work, color: Colors.white),
                  itemLabel: 'Properties',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.assignment, color: Colors.white54),
                  activeItem: Icon(Icons.assignment, color: Colors.white),
                  itemLabel: 'Requests',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.miscellaneous_services,
                    color: Colors.white54,
                  ),
                  activeItem: Icon(
                    Icons.miscellaneous_services,
                    color: Colors.white,
                  ),
                  itemLabel: 'Services',
                ),
              ],
              onTap: (index) {
                setStateInner(() {
                  _selectedIndex = index;
                  _notchController.index = index;
                });
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
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
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Exit',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
        )) ??
        false;
  }
}
