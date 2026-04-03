import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'request_details_page.dart'; // Import the new file for RequestDetailsPage

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ManagerRequestsPage extends StatefulWidget {
  const ManagerRequestsPage({super.key});

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
  String _selectedStatus = 'All';
  String _searchText = '';

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'New':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusList =
        _requests.map((e) => e['status'] as String).toSet().toList();
    final allStatuses = <String>['All', ...statusList];

    final filteredRequests =
        _requests.where((e) {
          final matchesStatus =
              _selectedStatus == 'All' || _selectedStatus == e['status'];
          final search = _searchText.trim().toLowerCase();
          final matchesSearch =
              search.isEmpty ||
              e['title'].toString().toLowerCase().contains(search) ||
              e['description'].toString().toLowerCase().contains(search) ||
              e['id'].toString().toLowerCase().contains(search) ||
              e['createdBy'].toString().toLowerCase().contains(search);
          return matchesStatus && matchesSearch;
        }).toList();

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
                      'Service Requests',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Track, prioritize and resolve service requests quickly',
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
                  Icons.support_agent_rounded,
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
              hintText: 'Search by title, description, ID, or creator',
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
          children:
              allStatuses
                  .map(
                    (status) => _FilterPill(
                      icon:
                          status == 'All'
                              ? Icons.layers_rounded
                              : Icons.flag_circle_outlined,
                      label: status,
                      isActive: _selectedStatus == status,
                      onTap: () {
                        setState(() {
                          _selectedStatus = status;
                        });
                      },
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 18),
        if (filteredRequests.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'No requests match your search/filter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ...filteredRequests.map(
            (req) => _RequestItemCard(
              request: req,
              statusColor: _statusColor(req['status'] as String),
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestDetailsPage(request: req),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _RequestItemCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final Color statusColor;
  final VoidCallback onView;

  const _RequestItemCard({
    required this.request,
    required this.statusColor,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final vendor = (request['vendor'] as String).trim();
    final vendorText = vendor.isEmpty ? 'Unassigned' : vendor;

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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD9E2EC), Color(0xFFBCCCDC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.build_circle_outlined,
                    color: Color(0xFF243B53),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request['title'] as String,
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
                          _RequestQuickTag(text: 'ID ${request['id']}'),
                          _RequestQuickTag(
                            text: request['createdBy'] as String,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _StatusChip(
                  label: request['status'] as String,
                  color: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              request['description'] as String,
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
                  _RequestDetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date',
                    value: request['date'] as String,
                  ),
                  _RequestDetailRow(
                    icon: Icons.access_time_outlined,
                    label: 'Time',
                    value: request['time'] as String,
                  ),
                  _RequestDetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: request['address'] as String,
                  ),
                  _RequestDetailRow(
                    icon: Icons.handyman_outlined,
                    label: 'Assigned Vendor',
                    value: vendorText,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: onView,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blueGrey.shade100),
                    foregroundColor: const Color(0xFF243B53),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: Text(
                    'View Details',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ),
              ],
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

class _RequestQuickTag extends StatelessWidget {
  final String text;

  const _RequestQuickTag({required this.text});

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

class _RequestDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _RequestDetailRow({
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
            width: 96,
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
