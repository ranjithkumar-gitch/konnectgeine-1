import 'package:flutter/material.dart';

String formatDisplayDate(String dateStr) {
  final dt = DateTime.tryParse(dateStr);
  if (dt == null) return dateStr;
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];
  final day = dt.day.toString().padLeft(2, '0');
  final month = months[dt.month - 1];
  final year = dt.year;
  return '$day $month $year';
}

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({Key? key}) : super(key: key);

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  final List<Map<String, dynamic>> _requests = [
    {
      'id': 'R1001',
      'service': 'Plumbing',
      'icon': Icons.plumbing,
      'date': '2025-08-18',
      'time': '10:30 AM',
      'status': 'Pending',
    },
    {
      'id': 'R1002',
      'service': 'Electrical',
      'icon': Icons.electrical_services,
      'date': '2025-08-17',
      'time': '02:00 PM',
      'status': 'Completed',
    },
    {
      'id': 'R1003',
      'service': 'Paints',
      'icon': Icons.format_paint,
      'date': '2025-08-16',
      'time': '11:15 AM',
      'status': 'Hold',
    },
    {
      'id': 'R1004',
      'service': 'AC',
      'icon': Icons.ac_unit,
      'date': '2025-08-15',
      'time': '09:00 AM',
      'status': 'Completed',
    },
    {
      'id': 'R1005',
      'service': 'Bathroom Cleaning',
      'icon': Icons.bathtub,
      'date': '2025-08-14',
      'time': '04:45 PM',
      'status': 'Pending',
    },
    // Additional sample requests
    {
      'id': 'R1006',
      'service': 'Carpentry',
      'icon': Icons.chair,
      'date': '2025-08-13',
      'time': '01:20 PM',
      'status': 'Pending',
    },
    {
      'id': 'R1007',
      'service': 'Pest Control',
      'icon': Icons.bug_report,
      'date': '2025-08-12',
      'time': '03:30 PM',
      'status': 'Completed',
    },
    {
      'id': 'R1008',
      'service': 'Gardening',
      'icon': Icons.grass,
      'date': '2025-08-11',
      'time': '08:00 AM',
      'status': 'Hold',
    },
    {
      'id': 'R1009',
      'service': 'Security',
      'icon': Icons.security,
      'date': '2025-08-10',
      'time': '06:45 PM',
      'status': 'Pending',
    },
    {
      'id': 'R1010',
      'service': 'Internet',
      'icon': Icons.wifi,
      'date': '2025-08-09',
      'time': '12:10 PM',
      'status': 'Completed',
    },
  ];

  String? _selectedStatus;
  DateTime? _fromDate;
  DateTime? _toDate;
  String _searchText = '';

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Hold':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> get _filteredRequests {
    return _requests.where((req) {
      final matchesStatus =
          _selectedStatus == null || req['status'] == _selectedStatus;
      final reqDate = DateTime.tryParse(req['date']);
      final matchesFrom =
          _fromDate == null ||
          (reqDate != null && !reqDate.isBefore(_fromDate!));
      final matchesTo =
          _toDate == null || (reqDate != null && !reqDate.isAfter(_toDate!));
      final matchesText =
          _searchText.isEmpty ||
          req['service'].toString().toLowerCase().contains(
            _searchText.toLowerCase(),
          );
      return matchesStatus && matchesFrom && matchesTo && matchesText;
    }).toList();
  }

  void _showFilterDialog() async {
    String? tempStatus = _selectedStatus;
    DateTime? tempFromDate = _fromDate;
    DateTime? tempToDate = _toDate;
    String tempText = _searchText;
    final statuses =
        _requests.map((e) => e['status'] as String).toSet().toList();
    final textController = TextEditingController(text: tempText);
    String? errorText;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filter Requests',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Search by Service',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      controller: textController,
                      onChanged: (val) => tempText = val,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: tempFromDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                tempFromDate = picked;
                                setStateDialog(() {});
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'From Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                              ),
                              child: Text(
                                tempFromDate != null
                                    ? '${tempFromDate!.year}-${tempFromDate!.month.toString().padLeft(2, '0')}-${tempFromDate!.day.toString().padLeft(2, '0')}'
                                    : 'Select',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: tempToDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                tempToDate = picked;
                                setStateDialog(() {});
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'To Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                              ),
                              child: Text(
                                tempToDate != null
                                    ? '${tempToDate!.year}-${tempToDate!.month.toString().padLeft(2, '0')}-${tempToDate!.day.toString().padLeft(2, '0')}'
                                    : 'Select',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (errorText != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        errorText!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('All Statuses'),
                          selected: tempStatus == null,
                          onSelected:
                              (_) => setStateDialog(() => tempStatus = null),
                          selectedColor: Colors.amber.shade100,
                        ),
                        ...statuses.map(
                          (s) => ChoiceChip(
                            label: Text(s),
                            selected: tempStatus == s,
                            onSelected:
                                (_) => setStateDialog(() => tempStatus = s),
                            selectedColor: Colors.amber.shade100,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Clear Filters',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedStatus = null;
                              _fromDate = null;
                              _toDate = null;
                              _searchText = '';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            final now = DateTime.now();
                            if (tempFromDate != null &&
                                tempToDate != null &&
                                tempFromDate!.isAfter(tempToDate!)) {
                              setStateDialog(() {
                                errorText =
                                    'From date should be before or same as To date.';
                              });
                              return;
                            }
                            if (tempToDate != null &&
                                tempToDate!.isAfter(
                                  DateTime(now.year, now.month, now.day),
                                )) {
                              setStateDialog(() {
                                errorText = 'To date cannot be after today.';
                              });
                              return;
                            }
                            setState(() {
                              _selectedStatus = tempStatus;
                              _fromDate = tempFromDate;
                              _toDate = tempToDate;
                              _searchText = tempText;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: const Color(0xFFF7F7FA),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Raised Requests',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.1,
                      color: Color(0xFF22223B),
                    ),
                  ),
                  Material(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: _showFilterDialog,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.amber.shade800,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  _filteredRequests.isEmpty
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
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        itemCount: _filteredRequests.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 18),
                        itemBuilder: (context, idx) {
                          final req = _filteredRequests[idx];
                          return Card(
                            elevation: 4,
                            shadowColor: Colors.amber.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            req['icon'],
                                            color: Colors.amber.shade700,
                                            size: 22,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            req['service'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                                        formatDisplayDate(req['date']),
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
                                                  : req['status'] == 'Hold'
                                                  ? Colors.red.shade100
                                                  : Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          req['status'],
                                          style: TextStyle(
                                            color:
                                                req['status'] == 'Completed'
                                                    ? Colors.green.shade800
                                                    : req['status'] == 'Pending'
                                                    ? Colors.orange.shade800
                                                    : req['status'] == 'Hold'
                                                    ? Colors.red.shade800
                                                    : Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
