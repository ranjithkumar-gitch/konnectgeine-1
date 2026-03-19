import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'my_requests_page.dart';
import 'menu_page.dart';
import '../authentication/login_screen.dart';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:kf_drawer/kf_drawer.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

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
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: _kBrandGradient),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                'Konnect @Property',
                style: TextStyle(color: Colors.white),
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
                onPressed: () => _drawerController.toggle!(),
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
                  onPressed: () async {
                    final shouldLogout = await _showLogoutDialog(context);
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
              color: _kBrandSecondary,
              showLabel: true,
              notchColor: const Color(0xFF2C5AA0),
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
      decoration: const BoxDecoration(gradient: _kBrandGradient),
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
        )) ??
        false;
  }
}
