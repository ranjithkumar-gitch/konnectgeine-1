import 'package:KonnectGenie/models/roles.dart';
import 'package:flutter/material.dart';

class RoleSelectionDialog extends StatelessWidget {
  final List<Role> roles;

  const RoleSelectionDialog({super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Role"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            roles
                .map(
                  (role) => ListTile(
                    title: Text(role.name),
                    onTap: () => Navigator.pop(context, role),
                  ),
                )
                .toList(),
      ),
    );
  }
}
