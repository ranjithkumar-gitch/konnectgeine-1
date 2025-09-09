import 'package:flutter/material.dart';

class AddVendorPage extends StatelessWidget {
  const AddVendorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Vendor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vendor Name'),
            TextField(),
            const SizedBox(height: 16),
            const Text('Company Name'),
            TextField(),
            const SizedBox(height: 16),
            const Text('Phone'),
            TextField(),
            const SizedBox(height: 16),
            const Text('Email'),
            TextField(),
            const SizedBox(height: 16),
            const Text('Category'),
            TextField(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save vendor logic here
                Navigator.pop(context);
              },
              child: const Text('Add Vendor'),
            ),
          ],
        ),
      ),
    );
  }
}
