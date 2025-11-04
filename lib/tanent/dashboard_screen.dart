import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'my_requests_page.dart';
import 'menu_page.dart';
import '../authentication/login_screen.dart';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:kf_drawer/kf_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late KFDrawerController _drawerController;
  final NotchBottomBarController _notchController = NotchBottomBarController(
    index: 0,
  );
  int _selectedIndex = 0;
  final List<Widget> _pages = const [HomePage(), MyRequestsPage(), MenuPage()];

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: _buildMainScreen(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text(
            'Dashboard',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(Icons.dashboard, color: Colors.white),
          page: _buildMainScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Service Requests',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(Icons.assignment, color: Colors.white),
          page: _buildMainScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Payments',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(Icons.payment, color: Colors.white),
          page: _buildMainScreen(),
        ),
      ],
    );
  }

  Widget _buildMainScreen() {
    return StatefulBuilder(
      builder: (context, setStateInner) {
        return WillPopScope(
          onWillPop: () async => await _showLogoutDialog(context),
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
                  inActiveItem: Icon(
                    Icons.menu_outlined,
                    color: Colors.white70,
                  ),
                  activeItem: Icon(Icons.menu, color: Colors.white),
                  itemLabel: 'Menu',
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

  @override
  Widget build(BuildContext context) {
    return KFDrawer(
      controller: _drawerController,
      header: _buildDrawerHeader(),
      footer: _buildDrawerFooter(context),
      decoration: const BoxDecoration(color: Colors.blueGrey),
    );
  }

  /// Drawer Header
  Widget _buildDrawerHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            Text(
              "Tenant",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent, // ✅ Allows background color to show
        child: ListTile(
          leading: const Icon(
            Icons.power_settings_new,
            color: Colors.redAccent,
          ),
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(color: Colors.redAccent),
          ),
          onTap: () async {
            final shouldLogout = await _showLogoutDialog(context);
            if (shouldLogout == true) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Text(
                  'Are you sure want to logout?',
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
                        color: const Color(0xFF098EDD),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
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
}
