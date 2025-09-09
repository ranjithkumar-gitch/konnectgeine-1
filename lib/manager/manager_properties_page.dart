import 'package:flutter/material.dart';
import 'property_details_page.dart';

class ManagerPropertiesPage extends StatefulWidget {
  const ManagerPropertiesPage({super.key});

  @override
  State<ManagerPropertiesPage> createState() => _ManagerPropertiesPageState();
}

class _ManagerPropertiesPageState extends State<ManagerPropertiesPage> {
  List<String> _selectedGroups = [];
  String _searchText = '';
  final List<Map<String, dynamic>> _properties = [
    {
      'id': 'P1001',
      'name': 'Sunshine Apartments',
      'address': '123 Main St, Downtown',
      'units': 40,
      'group': 'Alpha Group',
    },
    {
      'id': 'P1002',
      'name': 'Green Meadows',
      'address': '456 Park Ave, Midtown',
      'units': 32,
      'group': 'Beta Group',
    },
    {
      'id': 'P1003',
      'name': 'Blue Skies Residency',
      'address': '789 Lake Rd, Uptown',
      'units': 28,
      'group': 'Gamma Group',
    },
    {
      'id': 'P1004',
      'name': 'Palm Grove',
      'address': '321 Palm St, Suburbia',
      'units': 50,
      'group': 'Delta Group',
    },
    {
      'id': 'P1005',
      'name': 'Lakeview Towers',
      'address': '654 River Rd, Midtown',
      'units': 36,
      'group': 'Alpha Group',
    },
    {
      'id': 'P1006',
      'name': 'Maple Residency',
      'address': '987 Maple Ave, Downtown',
      'units': 22,
      'group': 'Beta Group',
    },
    {
      'id': 'P1007',
      'name': 'Orchid Enclave',
      'address': '159 Orchid St, Uptown',
      'units': 44,
      'group': 'Gamma Group',
    },
    {
      'id': 'P1008',
      'name': 'Cedar Heights',
      'address': '753 Cedar Rd, Suburbia',
      'units': 30,
      'group': 'Delta Group',
    },
    {
      'id': 'P1009',
      'name': 'Emerald Greens',
      'address': '852 Emerald Blvd, Midtown',
      'units': 38,
      'group': 'Alpha Group',
    },
    {
      'id': 'P1010',
      'name': 'Royal Residency',
      'address': '951 Royal St, Downtown',
      'units': 27,
      'group': 'Beta Group',
    },
    {
      'id': 'P1011',
      'name': 'Skyline Towers',
      'address': '357 Skyline Ave, Uptown',
      'units': 41,
      'group': 'Gamma Group',
    },
    {
      'id': 'P1012',
      'name': 'Willow Woods',
      'address': '258 Willow Rd, Suburbia',
      'units': 35,
      'group': 'Delta Group',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final groupNames =
        _properties.map((e) => e['group'] as String).toSet().toList();
    final filtered =
        _properties.where((e) {
          final matchesGroup =
              _selectedGroups.isEmpty || _selectedGroups.contains(e['group']);
          final search = _searchText.trim().toLowerCase();
          final matchesSearch =
              search.isEmpty ||
              e['name'].toString().toLowerCase().contains(search) ||
              e['address'].toString().toLowerCase().contains(search) ||
              e['id'].toString().toLowerCase().contains(search);
          return matchesGroup && matchesSearch;
        }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'List of Properties',
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
                  _selectedGroups.isNotEmpty || _searchText.isNotEmpty
                      ? 'Filtered'
                      : 'Filter',
                ),
                onPressed: () async {
                  String tempSearch = _searchText;
                  List<String> tempGroups = List.from(_selectedGroups);
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
                                    labelText: 'Search by name, address, or ID',
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
                                        groupNames.map((g) {
                                          final selected = tempGroups.contains(
                                            g,
                                          );
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                            ),
                                            child: ChoiceChip(
                                              label: Text(g),
                                              selected: selected,
                                              selectedColor:
                                                  Colors.blue.shade100,
                                              onSelected: (isSelected) {
                                                setStateDialog(() {
                                                  if (isSelected) {
                                                    tempGroups.add(g);
                                                  } else {
                                                    tempGroups.remove(g);
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
                                          'groups': <String>[],
                                          'search': '',
                                        });
                                      },
                                      child: const Text('Clear Filters'),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          () => Navigator.pop(context, {
                                            'groups': tempGroups,
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
                      _selectedGroups = List<String>.from(
                        selected['groups'] ?? [],
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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final prop = filtered[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PropertyDetailsPage(property: prop),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                prop['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
                                prop['id'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          prop['address'],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.apartment,
                              size: 18,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Units: ${prop['units']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 18),
                            Icon(
                              Icons.group,
                              size: 18,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Group: ${prop['group']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
