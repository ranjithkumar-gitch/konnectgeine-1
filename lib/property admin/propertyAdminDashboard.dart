import 'package:flutter/material.dart';

class PropertyAdminDashboard extends StatefulWidget {
  const PropertyAdminDashboard({super.key});

  @override
  State<PropertyAdminDashboard> createState() => _PropertyAdminDashboardState();
}

class _PropertyAdminDashboardState extends State<PropertyAdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Property Admin Dashboard"),
      ),
    );
  }
}
