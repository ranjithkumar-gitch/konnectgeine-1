import 'package:flutter/material.dart';

class ManagerServicesPage extends StatefulWidget {
  const ManagerServicesPage({Key? key}) : super(key: key);

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

  List<String> _selectedVerified = [];
  String _searchText = '';

  List<Map<String, dynamic>> get _filteredVendors {
    return _vendors.where((v) {
      final matchesVerified =
          _selectedVerified.isEmpty ||
          (_selectedVerified.contains('Verified') && v['verified'] == true) ||
          (_selectedVerified.contains('Unverified') && v['verified'] == false);
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
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'List of Vendors',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.filter_list),
                  label: Text(
                    _selectedVerified.isNotEmpty || _searchText.isNotEmpty
                        ? 'Filtered'
                        : 'Filter',
                  ),
                  onPressed: () async {
                    String tempSearch = _searchText;
                    List<String> tempVerified = List.from(_selectedVerified);
                    final selected = await showDialog<Map<String, dynamic>>(
                      context: context,
                      builder: (context) {
                        final controller = TextEditingController(
                          text: tempSearch,
                        );
                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return SimpleDialog(
                              title: const Text('Filter & Search'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      labelText: 'Search by any field',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (val) {
                                      setStateDialog(() {
                                        tempSearch = val;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      ChoiceChip(
                                        label: const Text('Verified'),
                                        selected: tempVerified.contains(
                                          'Verified',
                                        ),
                                        selectedColor: Colors.green.shade100,
                                        onSelected: (isSelected) {
                                          setStateDialog(() {
                                            if (isSelected) {
                                              tempVerified.add('Verified');
                                            } else {
                                              tempVerified.remove('Verified');
                                            }
                                          });
                                        },
                                        labelStyle: TextStyle(
                                          color:
                                              tempVerified.contains('Verified')
                                                  ? Colors.green.shade900
                                                  : Colors.black87,
                                          fontWeight:
                                              tempVerified.contains('Verified')
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ChoiceChip(
                                        label: const Text('Unverified'),
                                        selected: tempVerified.contains(
                                          'Unverified',
                                        ),
                                        selectedColor: Colors.red.shade100,
                                        onSelected: (isSelected) {
                                          setStateDialog(() {
                                            if (isSelected) {
                                              tempVerified.add('Unverified');
                                            } else {
                                              tempVerified.remove('Unverified');
                                            }
                                          });
                                        },
                                        labelStyle: TextStyle(
                                          color:
                                              tempVerified.contains(
                                                    'Unverified',
                                                  )
                                                  ? Colors.red.shade900
                                                  : Colors.black87,
                                          fontWeight:
                                              tempVerified.contains(
                                                    'Unverified',
                                                  )
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade400,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, {
                                            'verified': <String>[],
                                            'search': '',
                                          });
                                        },
                                        child: const Text('Clear Filters'),
                                      ),
                                      const SizedBox(width: 12),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.green.shade600,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        onPressed:
                                            () => Navigator.pop(context, {
                                              'verified': tempVerified,
                                              'search': tempSearch,
                                            }),
                                        child: const Text('Apply'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                    if (selected != null) {
                      setState(() {
                        _selectedVerified = List<String>.from(
                          selected['verified'] ?? [],
                        );
                        _searchText = selected['search'] ?? '';
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filteredVendors.length,
              separatorBuilder: (context, idx) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                final v = _filteredVendors[idx];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            v['idProof'] != null &&
                                    v['idProof'].toString().isNotEmpty
                                ? Image.network(
                                  v['idProof'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      ),
                                )
                                : Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey.shade100,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              v['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (v['verified'] == true)
                            Icon(
                              Icons.verified,
                              color: Colors.green.shade600,
                              size: 20,
                            )
                          else
                            Icon(
                              Icons.verified_outlined,
                              color: Colors.grey.shade400,
                              size: 20,
                            ),
                        ],
                      ),
                      subtitle: Text(
                        v['company'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.badge,
                              size: 18,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Vendor ID: ${v['id']}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.category,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Category: ${v['category']}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 18,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Phone: ${v['phone']}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 18,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Email: ${v['email']}',
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Company Address: ${v['companyAddress']}',
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        if (v['idProof'] != null &&
                            v['idProof'].toString().isNotEmpty)
                          Row(
                            children: [
                              const Icon(
                                Icons.image,
                                size: 18,
                                color: Colors.blueGrey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'ID Proof:',
                                style: const TextStyle(fontSize: 15),
                              ),
                              const SizedBox(width: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  v['idProof'],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        width: 40,
                                        height: 40,
                                        color: Colors.grey.shade200,
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
