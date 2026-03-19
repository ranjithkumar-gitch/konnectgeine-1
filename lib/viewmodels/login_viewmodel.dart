import 'package:KonnectGenie/main.dart';
// import 'package:KonnectGenie/models/loginResponseModel.dart' hide Role;
import 'package:KonnectGenie/models/logonRequestModel.dart';
import 'package:KonnectGenie/property%20admin/propertyAdminDashboard.dart';
import 'package:KonnectGenie/sharedpreferences/sharedprefservices.dart';
import 'package:flutter/material.dart';
import 'package:KonnectGenie/Vendor/vendor_Dashboard.dart';
import 'package:KonnectGenie/manager/manager_dashboard.dart';
import 'package:KonnectGenie/models/checkUserRequestModel.dart';
import 'package:KonnectGenie/owner/owner_dashboard.dart';

import 'package:KonnectGenie/repositories/auth_repository.dart';
import 'package:KonnectGenie/superadmin/superAdminDashboard.dart';
import 'package:KonnectGenie/tanent/dashboard_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  bool loading = false;

  Future<void> loginAndNavigate({
    required BuildContext context,
    required String emailOrPhone,
    required String password,
  }) async {
    loading = true;
    notifyListeners();

    try {
      final loginResponse = await _repository.login(
        LoginRequestModel(
          emailOrPhone: emailOrPhone.trim(),
          password: password.trim(),
          rememberMe: "true",
        ),
      );

      if (loginResponse.success) {
        if (loginResponse.token.isNotEmpty) {
          await SharedPrefServices.settoken(loginResponse.token);
          debugPrint("Token saved: ${loginResponse.token}");
        }

        final switchRoleResponse = await _repository.checkUser(
          CheckUserRequest(roleId: loginResponse.user.currentRoleId),
          loginResponse.token,
        );

        if (switchRoleResponse.success) {
          final role = switchRoleResponse.selectedRole;
          final roleKey = role.name.toLowerCase().replaceAll(" ", "");

          if (roleKey == "kgadmin") {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(builder: (_) => const SuperAdmin()),
            );
          } else if (roleKey == "tenant") {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
            );
          } else if (roleKey == "kgpmgr") {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(builder: (_) => const ManagerDashboard()),
            );
          } else if (roleKey == "vendoradmin") {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(builder: (_) => const VendorDashboard()),
            );
          } else if (roleKey == "propertyadmin") {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(builder: (_) => const PropertyAdminDashboard()),
            );
          } else if (roleKey == "propertyowner" || roleKey == "owner") {
            navigatorKey.currentState?.pushReplacement(
              MaterialPageRoute(builder: (_) => const OwnerDashboard()),
            );
          } else {
            ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
              SnackBar(content: Text("No dashboard mapped for ${role.name}")),
            );
          }
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(switchRoleResponse.message)));
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
