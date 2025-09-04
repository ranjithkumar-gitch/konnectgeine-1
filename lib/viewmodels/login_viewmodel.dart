import 'package:KonnectGenie/main.dart';
import 'package:KonnectGenie/models/loginResponseModel.dart' hide Role;
import 'package:KonnectGenie/models/logonRequestModel.dart';
import 'package:KonnectGenie/sharedpreferences/sharedprefservices.dart';
import 'package:flutter/material.dart';
import 'package:KonnectGenie/Vendor/vendor_Dashboard.dart';
import 'package:KonnectGenie/manager/manager_dashboard.dart';
import 'package:KonnectGenie/models/checkUserRequestModel.dart';

import 'package:KonnectGenie/models/roles.dart';
import 'package:KonnectGenie/repositories/auth_repository.dart';
import 'package:KonnectGenie/superadmin/superAdminDashboard.dart';
import 'package:KonnectGenie/tanent/dashboard_screen.dart';

// class LoginViewModel extends ChangeNotifier {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   final AuthRepository _repository = AuthRepository();
//   bool loading = false;

//   Future<void> checkUser({
//     required BuildContext context,
//     required String emailOrPhone,
//     required String password,
//   }) async {
//     loading = true;
//     notifyListeners();

//     try {
//       final checkUserResponse = await _repository.checkUser(
//         CheckUserRequest(emailOrPhone: emailOrPhone),
//       );

//       if (checkUserResponse.success && checkUserResponse.roles.isNotEmpty) {
//         _showRoleDialog(
//           context,
//           checkUserResponse.roles,
//           emailOrPhone,
//           password,
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(checkUserResponse.maskedInfo ?? "No roles found"),
//           ),
//         );
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Error: $e")));
//       }
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }

//   void _showRoleDialog(
//     BuildContext context,
//     List<Role> roles,
//     String emailOrPhone,
//     String password,
//   ) {
//     showDialog(
//       context: context,
//       builder:
//           (dialogContext) => AlertDialog(
//             title: const Text("Select Role"),
//             content: SizedBox(
//               width: double.maxFinite,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: roles.length,
//                 itemBuilder: (context, index) {
//                   final role = roles[index];
//                   return ListTile(
//                     title: Text(role.name),
//                     onTap: () {
//                       // Close dialog first
//                       Navigator.pop(dialogContext);

//                       // Then login with selected role
//                       _loginWithRole(context, emailOrPhone, password, role);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//     );
//   }

//   Future<void> _loginWithRole(
//     BuildContext context,
//     String emailOrPhone,
//     String password,
//     Role role,
//   ) async {
//     loading = true;
//     notifyListeners();

//     try {
//       final request = LoginRequestModel(
//         emailOrPhone: emailOrPhone.trim(),
//         password: password.trim(),
//         selectedRoleId: role.id,
//       );

//       final response = await _repository.login(request);

//       // ✅ Parse into model
//       final loginResponse = LoginResponse.fromJson(response);

//       if (loginResponse.success) {
//         // ✅ Save token to SharedPreferences
//         if (loginResponse.token != null && loginResponse.token!.isNotEmpty) {
//           await SharedPrefServices.settoken(loginResponse.token!);
//           print("✅ Token saved: ${loginResponse.token}");
//         }

//         // Debug print role name
//         print("🟢 Role received from API: ${role.name}");

//         final userName = loginResponse.user?.name ?? role.name;
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Login Successful as $userName")),
//           );
//         }

//         // ✅ Normalize role names for mapping
//         final roleKey = role.name.toLowerCase().replaceAll(" ", "");

//         if (context.mounted) {
//           if (roleKey == "superadmin") {
//             // Navigator.of(context, rootNavigator: true).pushReplacement(
//             //   MaterialPageRoute(builder: (_) => const SuperAdmin()),
//             // );
//             navigatorKey.currentState?.pushReplacement(
//               MaterialPageRoute(builder: (_) => const SuperAdmin()),
//             );
//           } else if (roleKey == "tenant") {
//             Navigator.of(context, rootNavigator: true).pushReplacement(
//               MaterialPageRoute(builder: (_) => const DashboardScreen()),
//             );
//           } else if (roleKey == "propertymanager") {
//             Navigator.of(context, rootNavigator: true).pushReplacement(
//               MaterialPageRoute(builder: (_) => const ManagerDashboard()),
//             );
//           } else if (roleKey == "vendor") {
//             Navigator.of(context, rootNavigator: true).pushReplacement(
//               MaterialPageRoute(builder: (_) => const VendorDashboard()),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("No dashboard mapped for ${role.name}")),
//             );
//           }
//           ;
//         }
//       } else {
//         if (context.mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text("Login failed")));
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Login error: $e")));
//       }
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
// }

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  bool loading = false;

  Future<void> checkUser({
    required BuildContext context,
    required String emailOrPhone,
    required String password,
  }) async {
    loading = true;
    notifyListeners();

    try {
      final checkUserResponse = await _repository.checkUser(
        CheckUserRequest(emailOrPhone: emailOrPhone),
      );

      if (checkUserResponse.success && checkUserResponse.roles.isNotEmpty) {
        _showRoleDialog(
          context,
          checkUserResponse.roles,
          emailOrPhone,
          password,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(checkUserResponse.maskedInfo ?? "No roles found"),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void _showRoleDialog(
    BuildContext context,
    List<Role> roles,
    String emailOrPhone,
    String password,
  ) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text("Select Role"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  final role = roles[index];
                  return ListTile(
                    title: Text(role.name),
                    onTap: () {
                      Navigator.pop(dialogContext); // Close dialog
                      _loginWithRole(emailOrPhone, password, role);
                    },
                  );
                },
              ),
            ),
          ),
    );
  }

  Future<void> _loginWithRole(
    String emailOrPhone,
    String password,
    Role role,
  ) async {
    loading = true;
    notifyListeners();

    try {
      final request = LoginRequestModel(
        emailOrPhone: emailOrPhone.trim(),
        password: password.trim(),
        selectedRoleId: role.id,
      );

      final response = await _repository.login(request);

      final loginResponse = LoginResponse.fromJson(response);

      if (loginResponse.success) {
        // ✅ Save token
        if (loginResponse.token != null && loginResponse.token!.isNotEmpty) {
          await SharedPrefServices.settoken(loginResponse.token!);
          print("✅ Token saved: ${loginResponse.token}");
        }

        print("🟢 Role received from API: ${role.name}");

        final userName = loginResponse.user?.name ?? role.name;
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(content: Text("Login Successful as $userName")),
        );

        // ✅ Normalize role name
        final roleKey = role.name.toLowerCase().replaceAll(" ", "");

        // ✅ Navigate without depending on widget context
        if (roleKey == "superadmin") {
          navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const SuperAdmin()),
          );
        } else if (roleKey == "tenant") {
          navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
          );
        } else if (roleKey == "propertymanager") {
          navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const ManagerDashboard()),
          );
        } else if (roleKey == "vendor") {
          navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const VendorDashboard()),
          );
        } else {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(content: Text("No dashboard mapped for ${role.name}")),
          );
        }
      } else {
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).showSnackBar(const SnackBar(content: Text("Login failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        navigatorKey.currentContext!,
      ).showSnackBar(SnackBar(content: Text("Login error: $e")));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
