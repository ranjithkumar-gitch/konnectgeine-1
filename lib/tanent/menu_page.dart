import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.amber.shade800,
            unselectedLabelColor: Colors.grey.shade400,
            indicatorColor: Colors.amber.shade800,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Profile', icon: Icon(Icons.person)),
              Tab(text: 'My Residence', icon: Icon(Icons.home)),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Profile Tab
          SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal: 22,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.amber.shade800,
                              size: 28,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Profile Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF22223B),
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/32.jpg',
                          ),
                          backgroundColor: Colors.amber.shade100,
                        ),
                        const SizedBox(height: 22),
                        _profileField('First Name', 'John'),
                        _profileField('Last Name', 'Doe'),
                        _profileField('Phone Number', '+91 9876543210'),
                        _profileField('Email', 'john.doe@email.com'),
                        _profileField(
                          'Address',
                          '123, Main Street, City, State, 123456',
                        ),
                        _profileField('Secondary Number', '+91 9123456780'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Residence Tab
          SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _residenceField('Property Name', 'Sunshine Apartments'),
                  _residenceField(
                    'Address',
                    '456, Residency Road, City, State, 654321',
                  ),
                  _residenceField('Tower', 'B'),
                  _residenceField('Building', 'Block 2'),
                  _residenceField('Floor', '5'),
                  _residenceField('Flat Number', '502'),
                  const SizedBox(height: 10),
                  Divider(height: 1, thickness: 1.2, color: Color(0xFFE0E0E0)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.amber.shade800,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Property Manager',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF22223B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _residenceField('Name', 'Priya Sharma'),
                  _residenceField('Phone', '+91 9001234567'),
                  _residenceField('Email', 'priya.sharma@propertymgmt.com'),
                  _residenceField('Office', 'Ground Floor, Tower B'),
                  // Property Owner Details
                  const SizedBox(height: 10),
                  Divider(height: 1, thickness: 1.2, color: Color(0xFFE0E0E0)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.amber.shade800,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Property Owner',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF22223B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _residenceField('Name', 'Srikanth Natarajan'),
                  _residenceFieldIcon('Phone', '+91 9001110012', Icons.phone),
                  _residenceField('Email', 'srikanth.n@gmail.com'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF22223B),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _residenceField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF22223B),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _residenceFieldIcon(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF22223B),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 24, color: Colors.orange),
        ],
      ),
    );
  }
}
