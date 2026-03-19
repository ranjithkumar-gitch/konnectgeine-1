import 'package:KonnectGenie/Vendor/vendor_Dashboard.dart';
import 'package:KonnectGenie/manager/manager_dashboard.dart';
import 'package:KonnectGenie/owner/owner_dashboard.dart';
import 'package:KonnectGenie/tanent/tenant_dashboard.dart';
import 'package:KonnectGenie/vendor_staff/vendor_staff_dashboard.dart';
import 'package:KonnectGenie/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController(
    text: 'lisa.montgomery@sunkpo.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'demo123',
  );
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _goToRegister() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _kBrandSecondary,
        content: Text(
          'Navigate to Register Page',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(
        color: const Color(0xFF6B7A90),
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: _kBrandPrimary),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF6F9FF),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD6E2F5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _kBrandPrimary, width: 1.4),
      ),
    );
  }

  Widget _buildSegmentToggle() {
    final bool isEmailSelected = _tabController.index == 0;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F1FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleItem(
              title: 'Email',
              selected: isEmailSelected,
              onTap: () => _tabController.animateTo(0),
            ),
          ),
          Expanded(
            child: _buildToggleItem(
              title: 'Mobile',
              selected: !isEmailSelected,
              onTap: () => _tabController.animateTo(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? Colors.white : Colors.transparent,
          boxShadow:
              selected
                  ? const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: selected ? _kBrandSecondary : const Color(0xFF6B7A90),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailFields() {
    return Column(
      key: const ValueKey('email-login'),
      children: [
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _inputDecoration(
            label: 'Email address',
            icon: Icons.alternate_email_rounded,
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: _inputDecoration(
            label: 'Password',
            icon: Icons.lock_outline_rounded,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: _kBrandPrimary,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFields() {
    return Column(
      key: const ValueKey('mobile-login'),
      children: [
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration(
            label: 'Phone number',
            icon: Icons.phone_iphone_rounded,
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration(
            label: 'OTP',
            icon: Icons.shield_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleChip({required String label, required VoidCallback onTap}) {
    return ActionChip(
      onPressed: onTap,
      backgroundColor: const Color(0xFFF6F9FF),
      side: const BorderSide(color: Color(0xFFD6E2F5)),
      avatar: const Icon(Icons.arrow_outward_rounded, size: 16),
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: _kBrandSecondary,
        ),
      ),
    );
  }

  Widget _buildLoginCard({required LoginViewModel vm}) {
    final bool isEmailLogin = _tabController.index == 0;
    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSegmentToggle(),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: isEmailLogin ? _buildEmailFields() : _buildMobileFields(),
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                gradient: _kBrandGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ElevatedButton(
                onPressed: () {
                  vm.loginAndNavigate(
                    context: context,
                    emailOrPhone:
                        isEmailLogin
                            ? _emailController.text.trim()
                            : _phoneController.text.trim(),
                    password:
                        isEmailLogin
                            ? _passwordController.text.trim()
                            : _otpController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child:
                    vm.loading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(
                          'Login Securely',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: [
                _buildRoleChip(
                  label: 'Property Manager',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const ManagerDashboard(),
                      ),
                    );
                  },
                ),
                _buildRoleChip(
                  label: 'Property Owner',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const OwnerDashboard(),
                      ),
                    );
                  },
                ),
                _buildRoleChip(
                  label: 'Vendor Admin',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const VendorDashboard(),
                      ),
                    );
                  },
                ),
                _buildRoleChip(
                  label: 'Vendor Staff',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const VendorStaffDashboard(),
                      ),
                    );
                  },
                ),
                _buildRoleChip(
                  label: 'Tenant',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const TenantDashboard(),
                      ),
                    );
                  },
                ),
                // _buildRoleChip(
                //   label: 'Property Admin',
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute<void>(
                //         builder: (_) => const PropertyAdminDashboard(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _goToRegister,
              child: Text(
                'Don\'t have an account? Register',
                style: GoogleFonts.poppins(
                  color: _kBrandPrimary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: _kBrandGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Column(
                children: [
                  Image.asset(
                    'images/konnect_logo.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sign in to continue to Konnect @Property',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withAlpha(210),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _buildLoginCard(vm: vm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
