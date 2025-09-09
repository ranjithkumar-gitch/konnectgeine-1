import 'package:KonnectGenie/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // bool isEmailSelected = true;
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController(
    text: "konnectgenie@admin.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "konnectgenie@2025",
  );
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Navigate to Register Page')));
  }

  Widget _buildLoginCard({
    required List<Widget> children,
    required LoginViewModel vm,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white.withOpacity(0.92),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabHeader("Email", 0),
                  _buildTabHeader("Mobile", 1),
                ],
              ),
              const SizedBox(height: 24),

              AnimatedBuilder(
                animation: _tabController,
                builder: (context, _) {
                  if (_tabController.index == 0) {
                    return _buildEmailFields();
                  } else {
                    return _buildMobileFields();
                  }
                },
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    vm.checkUser(
                      context: context,
                      emailOrPhone:
                          _tabController.index == 0
                              ? _emailController.text.trim()
                              : _phoneController.text.trim(),
                      password:
                          _tabController.index == 0
                              ? _passwordController.text.trim()
                              : _otpController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color(0xFF27ae60),
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
                          : const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.1,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: _goToRegister,
                child: const Text(
                  "Don't have an account? Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2980B9),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabHeader(String title, int index) {
    final bool isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
        setState(() {});
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 60,
            color: isSelected ? Colors.black : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildEmailFields() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email, color: Color(0xFF2980B9)),
            labelText: 'Email',
            labelStyle: const TextStyle(color: Color(0xFF2980B9)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 18),

        // TextField(
        //   controller: _passwordController,
        //   obscureText: true,
        //   decoration: InputDecoration(
        //     prefixIcon: const Icon(Icons.lock, color: Color(0xFF2980B9)),
        //     labelText: 'Password',
        //     labelStyle: const TextStyle(color: Color(0xFF2980B9)),
        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        //     filled: true,
        //     fillColor: Colors.grey[100],
        //   ),
        // ),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock, color: Color(0xFF2980B9)),
            labelText: 'Password',
            labelStyle: const TextStyle(color: Color(0xFF2980B9)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey[100],
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF2980B9),
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
      children: [
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone, color: Color(0xFF2980B9)),
            labelText: 'Phone Number',
            labelStyle: const TextStyle(color: Color(0xFF2980B9)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF2980B9),
            ),
            labelText: 'OTP',
            labelStyle: const TextStyle(color: Color(0xFF2980B9)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'images/kg_logo.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
                _buildLoginCard(children: const [], vm: vm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
