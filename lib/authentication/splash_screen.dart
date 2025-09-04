import 'package:KonnectGenie/tanent/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:KonnectGenie/authentication/login_screen.dart';
import 'package:KonnectGenie/manager/manager_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      // MaterialPageRoute(builder: (context) => const ManagerDashboard()),
      // MaterialPageRoute(builder: (context) => const LoginScreen()),
    ); // Replace with your login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/kg_logo.png', height: 100),
            const SizedBox(height: 20),
            const Text(
              'KonnectGenie',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
