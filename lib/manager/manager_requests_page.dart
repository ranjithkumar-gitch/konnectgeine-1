import 'package:flutter/material.dart';
import 'request_details_page.dart'; // Import the new file for RequestDetailsPage

class ManagerRequestsPage extends StatefulWidget {
  const ManagerRequestsPage({Key? key}) : super(key: key);

  @override
  State<ManagerRequestsPage> createState() => _ManagerRequestsPageState();
}

class _ManagerRequestsPageState extends State<ManagerRequestsPage> {
  final List<Map<String, dynamic>> _requests = [
    {
      'id': 'R2001',
      'title': 'Leaking Faucet',
      'description': 'The kitchen faucet is leaking continuously.',
      'date': '2025-08-18',
      'time': '10:30 AM',
      'status': 'Pending',
      'createdBy': 'John Doe',
      'address': 'Apt 101, Sunshine Apartments, 123 Main St',
      'vendor': 'AquaFix Plumbing',
      'vendorCompany': 'AquaFix Solutions Pvt Ltd',
      'vendorContact': '+1 555-123-4567',
      'vendorEmail': 'support@aquafix.com',
      'attachments': [
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
      ],
    },
    {
      'id': 'R2002',
      'title': 'Power Outage',
      'description': 'No power in the living room since last night.',
      'date': '2025-08-17',
      'time': '09:00 AM',
      'status': 'Completed',
      'createdBy': 'Jane Smith',
      'address': 'Apt 305, Green Meadows, 456 Park Ave',
      'vendor': 'BrightSpark Electricals',
      'vendorCompany': 'BrightSpark Electric Co.',
      'vendorContact': '+1 555-987-6543',
      'vendorEmail': 'service@brightspark.com',
      'attachments': [
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      ],
    },
    {
      'id': 'R2003',
      'title': 'AC Not Cooling',
      'description': 'The bedroom AC is not cooling properly.',
      'date': '2025-08-16',
      'time': '02:15 PM',
      'status': 'In Progress',
      'createdBy': 'Alex Lee',
      'address': 'Apt 210, Blue Skies Residency, 789 Lake Rd',
      'vendor': 'CoolAir Services',
      'vendorCompany': 'CoolAir Comfort Ltd',
      'vendorContact': '+1 555-222-3344',
      'vendorEmail': 'help@coolair.com',
      'attachments': [
        'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=400&q=80',
      ],
    },
    {
      'id': 'R2004',
      'title': 'Broken Window',
      'description': 'Window glass in the hall is broken.',
      'date': '2025-08-15',
      'time': '11:00 AM',
      'status': 'Pending',
      'createdBy': 'Priya Kumar',
      'address': 'Apt 410, Palm Grove, 321 Palm St',
      'vendor': 'SafeGlass Repairs',
      'vendorCompany': 'SafeGlass Solutions',
      'vendorContact': '+1 555-333-7788',
      'vendorEmail': 'contact@safeglass.com',
      'attachments': [
        'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      ],
    },
    {
      'id': 'R2005',
      'title': 'Bathroom Cleaning',
      'description': 'Request for deep cleaning of bathroom.',
      'date': '2025-08-14',
      'time': '04:45 PM',
      'status': 'Completed',
      'createdBy': 'Rahul Mehra',
      'address': 'Apt 112, Lakeview Towers, 654 River Rd',
      'vendor': 'CleanPro Services',
      'vendorCompany': 'CleanPro Facility Management',
      'vendorContact': '+1 555-444-8899',
      'vendorEmail': 'info@cleanpro.com',
      'attachments': [
        'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      ],
    },
    {
      'id': 'R2006',
      'title': 'Water Heater Issue',
      'description': 'Water heater not working in the bathroom.',
      'date': '2025-08-19',
      'time': '08:00 AM',
      'status': 'New',
      'createdBy': 'Sonia Patel',
      'address': 'Apt 215, Maple Residency, 321 Maple St',
      'vendor': '',
      'vendorCompany': '',
      'vendorContact': '',
      'vendorEmail': '',
      'attachments': [
        'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=400&q=80',
      ],
    },
    {
      'id': 'R2007',
      'title': 'Pest Control Needed',
      'description': 'Ants in the kitchen and living room.',
      'date': '2025-08-19',
      'time': '09:30 AM',
      'status': 'New',
      'createdBy': 'Vikram Singh',
      'address': 'Apt 501, Lotus Heights, 789 Lotus Rd',
      'vendor': '',
      'vendorCompany': '',
      'vendorContact': '',
      'vendorEmail': '',
      'attachments': [
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      ],
    },
  ];
  List<bool> _expanded = [];
  List<String> _selectedStatuses = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _expanded = List.generate(_requests.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final statusList =
        _requests.map((e) => e['status'] as String).toSet().toList();
    final filteredRequests =
        _requests.where((e) {
          final matchesStatus =
              _selectedStatuses.isEmpty ||
              _selectedStatuses.contains(e['status']);
          final search = _searchText.trim().toLowerCase();
          final matchesSearch =
              search.isEmpty ||
              e['title'].toString().toLowerCase().contains(search) ||
              e['description'].toString().toLowerCase().contains(search) ||
              e['id'].toString().toLowerCase().contains(search) ||
              e['createdBy'].toString().toLowerCase().contains(search);
          return matchesStatus && matchesSearch;
        }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 24, 18, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Requests',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                    color: Color(0xFF22223B),
                  ),
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
                    _selectedStatuses.isNotEmpty || _searchText.isNotEmpty
                        ? 'Filtered'
                        : 'Filter',
                  ),

                  onPressed: () async {
                    String tempSearch = _searchText;
                    List<String> tempStatuses = List.from(_selectedStatuses);
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
                                      labelText:
                                          'Search by title, description, ID, or creator',
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
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children:
                                          statusList.map((s) {
                                            final selected = tempStatuses
                                                .contains(s);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4.0,
                                                  ),
                                              child: ChoiceChip(
                                                label: Text(s),
                                                selected: selected,
                                                selectedColor:
                                                    Colors.blue.shade100,
                                                onSelected: (isSelected) {
                                                  setStateDialog(() {
                                                    if (isSelected) {
                                                      tempStatuses.add(s);
                                                    } else {
                                                      tempStatuses.remove(s);
                                                    }
                                                  });
                                                },
                                                labelStyle: TextStyle(
                                                  color:
                                                      selected
                                                          ? Colors.blue.shade900
                                                          : Colors.black87,
                                                  fontWeight:
                                                      selected
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
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
                                            'statuses': <String>[],
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
                                              'statuses': tempStatuses,
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
                        _selectedStatuses = List<String>.from(
                          selected['statuses'] ?? [],
                        );
                        _searchText = selected['search'] ?? '';
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child:
                filteredRequests.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No requests found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      itemCount: filteredRequests.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, idx) {
                        final req = filteredRequests[idx];
                        return Card(
                          elevation: 4,
                          shadowColor: Colors.amber.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 0,
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
                              childrenPadding: EdgeInsets.zero,
                              title: Text(
                                req['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          req['status'] == 'Completed'
                                              ? Colors.green.shade100
                                              : req['status'] == 'Pending'
                                              ? Colors.orange.shade100
                                              : req['status'] == 'In Progress'
                                              ? Colors.blue.shade100
                                              : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      req['status'],
                                      style: TextStyle(
                                        color:
                                            req['status'] == 'Completed'
                                                ? Colors.green.shade800
                                                : req['status'] == 'Pending'
                                                ? Colors.orange.shade800
                                                : req['status'] == 'In Progress'
                                                ? Colors.blue.shade800
                                                : Colors.grey.shade800,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      req['id'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        req['description'],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            req['date'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Icon(
                                            Icons.access_time,
                                            size: 16,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            req['time'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'By: ${req['createdBy']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Colors.redAccent,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              req['address'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.handyman,
                                            size: 16,
                                            color: Colors.teal,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              'Assigned Vendor: ${req['vendor']}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.teal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => RequestDetailsPage(
                                                        request: req,
                                                      ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 12,
                                                  ),
                                            ),
                                            child: const Text('View Details'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
