import 'dart:io';

import 'package:KonnectGenie/manager/manager_properties_page.dart';
import 'package:KonnectGenie/manager/manager_requests_page.dart';
import 'package:KonnectGenie/manager/manager_services_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KonnectGenie/authentication/login_screen.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class SuperAdmin extends StatefulWidget {
  const SuperAdmin({super.key});

  @override
  State<SuperAdmin> createState() => _SuperAdminState();
}

class _SuperAdminState extends State<SuperAdmin> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    ManagerPropertiesPage(),
    ManagerRequestsPage(),
    ManagerServicesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        bool exitApp = await _showExitDialog(context);
        if (exitApp) {
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('SuperAdmin'),
          actions: [
            IconButton(
              icon: const Icon(Icons.power_settings_new, color: Colors.red),
              tooltip: 'Logout',
              onPressed: () async {
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
                        actions: <Widget>[
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
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
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
                              style: GoogleFonts.poppins(
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
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
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
                  'Do you want to exit the app ?',
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
                        color: Color(0xFF098EDD),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      exit(0);
                    },
                    child: Text(
                      'Exit',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF098EDD),
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
