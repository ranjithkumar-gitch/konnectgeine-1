import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerServicesPage extends StatefulWidget {
  const ManagerServicesPage({super.key});

  @override
  State<ManagerServicesPage> createState() => _ManagerServicesPageState();
}

class _ManagerServicesPageState extends State<ManagerServicesPage> {
  final List<Map<String, dynamic>> _vendors = [
    // Plumbing
    {
      'id': 'V1001',
      'name': 'AquaFix Plumbing',
      'company': 'AquaFix Solutions Pvt Ltd',
      'phone': '+1 555-123-4567',
      'email': 'support@aquafix.com',
      'companyAddress': '123 Water St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Plumbing',
    },
    {
      'id': 'V1002',
      'name': 'PipeMasters',
      'company': 'PipeMasters Inc.',
      'phone': '+1 555-234-5678',
      'email': 'info@pipemasters.com',
      'companyAddress': '234 Pipe Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Plumbing',
    },
    {
      'id': 'V1003',
      'name': 'FlowRight',
      'company': 'FlowRight Services',
      'phone': '+1 555-345-6789',
      'email': 'contact@flowright.com',
      'companyAddress': '345 Flow St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Plumbing',
    },
    // Electrical
    {
      'id': 'V2001',
      'name': 'BrightSpark Electricals',
      'company': 'BrightSpark Electric Co.',
      'phone': '+1 555-987-6543',
      'email': 'service@brightspark.com',
      'companyAddress': '456 Spark Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Electrical',
    },
    {
      'id': 'V2002',
      'name': 'WattWorks',
      'company': 'WattWorks Solutions',
      'phone': '+1 555-876-5432',
      'email': 'hello@wattworks.com',
      'companyAddress': '789 Watt St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Electrical',
    },
    {
      'id': 'V2003',
      'name': 'PowerPros',
      'company': 'PowerPros Ltd',
      'phone': '+1 555-765-4321',
      'email': 'support@powerpros.com',
      'companyAddress': '321 Power Ave, Suburbia',
      'idProof':
          'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Electrical',
    },
    // Paints
    {
      'id': 'V3001',
      'name': 'ColorCrafters',
      'company': 'ColorCrafters Paints',
      'phone': '+1 555-654-3210',
      'email': 'info@colorcrafters.com',
      'companyAddress': '654 Paint St, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Paints',
    },
    {
      'id': 'V3002',
      'name': 'PaintPro',
      'company': 'PaintPro Services',
      'phone': '+1 555-543-2109',
      'email': 'contact@paintpro.com',
      'companyAddress': '987 Color Ave, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Paints',
    },
    {
      'id': 'V3003',
      'name': 'BrushMasters',
      'company': 'BrushMasters Ltd',
      'phone': '+1 555-432-1098',
      'email': 'hello@brushmasters.com',
      'companyAddress': '321 Brush St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Paints',
    },
    // AC
    {
      'id': 'V4001',
      'name': 'CoolAir Services',
      'company': 'CoolAir Comfort Ltd',
      'phone': '+1 555-222-3344',
      'email': 'help@coolair.com',
      'companyAddress': '789 Cool Rd, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'AC',
    },
    {
      'id': 'V4002',
      'name': 'FrostyFix',
      'company': 'FrostyFix Solutions',
      'phone': '+1 555-321-0987',
      'email': 'support@frostyfix.com',
      'companyAddress': '654 Chill St, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'AC',
    },
    {
      'id': 'V4003',
      'name': 'AirFlow Pros',
      'company': 'AirFlow Pros Ltd',
      'phone': '+1 555-210-9876',
      'email': 'contact@airflowpros.com',
      'companyAddress': '987 Air Ave, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'AC',
    },
    // Pest Control
    {
      'id': 'V5001',
      'name': 'PestAway',
      'company': 'PestAway Control',
      'phone': '+1 555-111-2222',
      'email': 'contact@pestaway.com',
      'companyAddress': '111 Pest St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Pest Control',
    },
    {
      'id': 'V5002',
      'name': 'SafeHome Pest',
      'company': 'SafeHome Pest Solutions',
      'phone': '+1 555-333-4444',
      'email': 'service@safehomepest.com',
      'companyAddress': '333 Bug Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Pest Control',
    },
    {
      'id': 'V5003',
      'name': 'BugBusters',
      'company': 'BugBusters Ltd',
      'phone': '+1 555-444-5555',
      'email': 'info@bugbusters.com',
      'companyAddress': '444 Insect St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Pest Control',
    },
    // Carpet Cleaning
    {
      'id': 'V6001',
      'name': 'CleanCarpet Pros',
      'company': 'CleanCarpet Pros Ltd',
      'phone': '+1 555-555-6666',
      'email': 'contact@cleancarpet.com',
      'companyAddress': '555 Carpet Ave, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Carpet Cleaning',
    },
    {
      'id': 'V6002',
      'name': 'CarpetCare',
      'company': 'CarpetCare Solutions',
      'phone': '+1 555-666-7777',
      'email': 'info@carpetcare.com',
      'companyAddress': '666 Rug St, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Carpet Cleaning',
    },
    {
      'id': 'V6003',
      'name': 'RugMasters',
      'company': 'RugMasters Ltd',
      'phone': '+1 555-777-8888',
      'email': 'contact@rugmasters.com',
      'companyAddress': '777 Rug Ave, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Carpet Cleaning',
    },
    // Floor Cleaning
    {
      'id': 'V7001',
      'name': 'FloorShine',
      'company': 'FloorShine Services',
      'phone': '+1 555-888-9999',
      'email': 'info@floorshine.com',
      'companyAddress': '888 Shine St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Floor Cleaning',
    },
    {
      'id': 'V7002',
      'name': 'CleanFloors',
      'company': 'CleanFloors Ltd',
      'phone': '+1 555-999-0000',
      'email': 'contact@cleanfloors.com',
      'companyAddress': '999 Floor Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Floor Cleaning',
    },
    {
      'id': 'V7003',
      'name': 'ShinyTiles',
      'company': 'ShinyTiles Solutions',
      'phone': '+1 555-000-1111',
      'email': 'info@shinytiles.com',
      'companyAddress': '111 Tile St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Floor Cleaning',
    },
    // Bathroom Cleaning
    {
      'id': 'V8001',
      'name': 'BathClean Pros',
      'company': 'BathClean Pros Ltd',
      'phone': '+1 555-111-2223',
      'email': 'contact@bathclean.com',
      'companyAddress': '222 Bath St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Bathroom Cleaning',
    },
    {
      'id': 'V8002',
      'name': 'CleanBaths',
      'company': 'CleanBaths Ltd',
      'phone': '+1 555-222-3334',
      'email': 'info@cleanbaths.com',
      'companyAddress': '333 Bath Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Bathroom Cleaning',
    },
    {
      'id': 'V8003',
      'name': 'ShowerShine',
      'company': 'ShowerShine Solutions',
      'phone': '+1 555-333-4445',
      'email': 'contact@showershine.com',
      'companyAddress': '444 Shower St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Bathroom Cleaning',
    },
    // Dusting
    {
      'id': 'V9001',
      'name': 'DustAway',
      'company': 'DustAway Services',
      'phone': '+1 555-444-5556',
      'email': 'info@dustaway.com',
      'companyAddress': '555 Dust St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Dusting',
    },
    {
      'id': 'V9002',
      'name': 'CleanDust',
      'company': 'CleanDust Ltd',
      'phone': '+1 555-555-6667',
      'email': 'contact@cleandust.com',
      'companyAddress': '666 Dust Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Dusting',
    },
    {
      'id': 'V9003',
      'name': 'DustBusters',
      'company': 'DustBusters Ltd',
      'phone': '+1 555-666-7778',
      'email': 'info@dustbusters.com',
      'companyAddress': '777 Dust Ave, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Dusting',
    },
    // Vaccuming
    {
      'id': 'V10001',
      'name': 'VacuumPros',
      'company': 'VacuumPros Ltd',
      'phone': '+1 555-777-8889',
      'email': 'info@vacuumpros.com',
      'companyAddress': '888 Vacuum St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Vaccuming',
    },
    {
      'id': 'V10002',
      'name': 'CleanVac',
      'company': 'CleanVac Solutions',
      'phone': '+1 555-888-9990',
      'email': 'contact@cleanvac.com',
      'companyAddress': '999 Vac Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Vaccuming',
    },
    {
      'id': 'V10003',
      'name': 'VacuumMasters',
      'company': 'VacuumMasters Ltd',
      'phone': '+1 555-999-0001',
      'email': 'info@vacuummasters.com',
      'companyAddress': '111 Vac St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Vaccuming',
    },
    // Dishwasher
    {
      'id': 'V11001',
      'name': 'DishClean Pros',
      'company': 'DishClean Pros Ltd',
      'phone': '+1 555-000-1112',
      'email': 'info@dishclean.com',
      'companyAddress': '222 Dish St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Dishwasher',
    },
    {
      'id': 'V11002',
      'name': 'CleanDish',
      'company': 'CleanDish Ltd',
      'phone': '+1 555-111-2224',
      'email': 'contact@cleandish.com',
      'companyAddress': '333 Dish Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Dishwasher',
    },
    {
      'id': 'V11003',
      'name': 'DishMasters',
      'company': 'DishMasters Ltd',
      'phone': '+1 555-222-3335',
      'email': 'info@dishmasters.com',
      'companyAddress': '444 Dish Ave, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Dishwasher',
    },
    // Others
    {
      'id': 'V12001',
      'name': 'HandyHelpers',
      'company': 'HandyHelpers Ltd',
      'phone': '+1 555-333-4446',
      'email': 'info@handyhelpers.com',
      'companyAddress': '555 Help St, Downtown',
      'idProof':
          'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Others',
    },
    {
      'id': 'V12002',
      'name': 'FixItAll',
      'company': 'FixItAll Solutions',
      'phone': '+1 555-444-5557',
      'email': 'contact@fixitall.com',
      'companyAddress': '666 Fix Ave, Midtown',
      'idProof':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'verified': false,
      'category': 'Others',
    },
    {
      'id': 'V12003',
      'name': 'QuickFix',
      'company': 'QuickFix Ltd',
      'phone': '+1 555-555-6668',
      'email': 'info@quickfix.com',
      'companyAddress': '777 Quick St, Uptown',
      'idProof':
          'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      'verified': true,
      'category': 'Others',
    },
  ];

  String _selectedVerification = 'All';
  String _searchText = '';

  List<Map<String, dynamic>> get _filteredVendors {
    return _vendors.where((v) {
      final matchesVerified =
          _selectedVerification == 'All' ||
          (_selectedVerification == 'Verified' && v['verified'] == true) ||
          (_selectedVerification == 'Unverified' && v['verified'] == false);
      final search = _searchText.trim().toLowerCase();
      final matchesSearch =
          search.isEmpty ||
          v['name'].toString().toLowerCase().contains(search) ||
          v['company'].toString().toLowerCase().contains(search) ||
          v['phone'].toString().toLowerCase().contains(search) ||
          v['email'].toString().toLowerCase().contains(search) ||
          v['companyAddress'].toString().toLowerCase().contains(search) ||
          v['id'].toString().toLowerCase().contains(search) ||
          v['category'].toString().toLowerCase().contains(search);
      return matchesVerified && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + kBottomNavigationBarHeight),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: _kBrandGradient,
            boxShadow: [
              BoxShadow(
                color: _kBrandSecondary.withOpacity(0.22),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage trusted vendors and service categories',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        height: 1.3,
                        color: Colors.white.withOpacity(0.82),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.miscellaneous_services,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by vendor name, category, ID, phone or email',
              hintStyle: GoogleFonts.poppins(fontSize: 13),
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _FilterPill(
              icon: Icons.layers_rounded,
              label: 'All',
              isActive: _selectedVerification == 'All',
              onTap: () {
                setState(() {
                  _selectedVerification = 'All';
                });
              },
            ),
            _FilterPill(
              icon: Icons.verified_rounded,
              label: 'Verified',
              isActive: _selectedVerification == 'Verified',
              onTap: () {
                setState(() {
                  _selectedVerification = 'Verified';
                });
              },
            ),
            _FilterPill(
              icon: Icons.gpp_bad_outlined,
              label: 'Unverified',
              isActive: _selectedVerification == 'Unverified',
              onTap: () {
                setState(() {
                  _selectedVerification = 'Unverified';
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 18),
        if (_filteredVendors.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'No vendors match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ..._filteredVendors.map((vendor) => _VendorItemCard(vendor: vendor)),
      ],
    );
  }
}

class _VendorItemCard extends StatelessWidget {
  final Map<String, dynamic> vendor;

  const _VendorItemCard({required this.vendor});

  @override
  Widget build(BuildContext context) {
    final isVerified = vendor['verified'] == true;
    final statusColor = isVerified ? Colors.green : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:
                      vendor['idProof'] != null &&
                              vendor['idProof'].toString().isNotEmpty
                          ? Image.network(
                            vendor['idProof'] as String,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 48,
                                  height: 48,
                                  color: const Color(0xFFEAF1FB),
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                    color: Color(0xFF243B53),
                                  ),
                                ),
                          )
                          : Container(
                            width: 48,
                            height: 48,
                            color: const Color(0xFFEAF1FB),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              color: Color(0xFF243B53),
                            ),
                          ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor['name'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _VendorQuickTag(text: 'ID ${vendor['id']}'),
                          _VendorQuickTag(text: vendor['category'] as String),
                        ],
                      ),
                    ],
                  ),
                ),
                _StatusChip(
                  label: isVerified ? 'Verified' : 'Unverified',
                  color: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              vendor['company'] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF334E68),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _VendorDetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: vendor['phone'] as String,
                  ),
                  _VendorDetailRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: vendor['email'] as String,
                  ),
                  _VendorDetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: vendor['companyAddress'] as String,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _FilterPill({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = isActive ? Colors.white : _kBrandSecondary;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          gradient: isActive ? _kBrandGradient : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? _kBrandSecondary : Colors.blueGrey.shade100,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: fgColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VendorQuickTag extends StatelessWidget {
  final String text;

  const _VendorQuickTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _kBrandSecondary.withOpacity(0.18)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: _kBrandSecondary,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.22)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _VendorDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _VendorDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey[400]),
          const SizedBox(width: 8),
          SizedBox(
            width: 74,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kBrandSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
