import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class RequestDetailsPage extends StatefulWidget {
  final Map<String, dynamic> request;
  const RequestDetailsPage({super.key, required this.request});

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  bool showVendorDropdown = false;
  String? selectedVendor;

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

  // Example vendor lists by request type/title
  List<Map<String, String>> getVendorsForRequest(String title) {
    if (title.toLowerCase().contains('water') ||
        title.toLowerCase().contains('heater')) {
      return [
        {
          'name': 'AquaFix Plumbing',
          'company': 'AquaFix Solutions Pvt Ltd',
          'contact': '+1 555-123-4567',
          'email': 'support@aquafix.com',
        },
        {
          'name': 'HotFlow Services',
          'company': 'HotFlow Water Solutions',
          'contact': '+1 555-888-9999',
          'email': 'info@hotflow.com',
        },
      ];
    } else if (title.toLowerCase().contains('pest')) {
      return [
        {
          'name': 'PestAway',
          'company': 'PestAway Control',
          'contact': '+1 555-111-2222',
          'email': 'contact@pestaway.com',
        },
        {
          'name': 'SafeHome Pest',
          'company': 'SafeHome Pest Solutions',
          'contact': '+1 555-333-4444',
          'email': 'service@safehomepest.com',
        },
      ];
    }

    return [
      {
        'name': 'General Vendor',
        'company': 'General Services',
        'contact': '+1 555-000-0000',
        'email': 'info@general.com',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.request;
    final isNewRequest = request['status'] == 'New';
    final vendors = getVendorsForRequest(request['title'] ?? '');
    final attachments =
        request['attachments'] is List
            ? request['attachments'] as List
            : <dynamic>[];
    final status = request['status']?.toString() ?? 'Unknown';
    final statusColor = _statusColor(status);
    final vendorName = request['vendor']?.toString() ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        title: Text(
          'Request Details',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
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
                        request['title']?.toString() ?? 'Service Request',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Track request lifecycle and assign vendors instantly',
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
                    Icons.build_circle_outlined,
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
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _QuickTag(text: 'ID ${request['id']}'),
                            _QuickTag(
                              text: request['createdBy']?.toString() ?? 'User',
                            ),
                          ],
                        ),
                      ),
                      _StatusChip(label: status, color: statusColor),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    request['title']?.toString() ?? '-',
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF102A43),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    request['description']?.toString() ?? '-',
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
                        _DetailRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Date',
                          value: request['date']?.toString() ?? '-',
                        ),
                        _DetailRow(
                          icon: Icons.access_time_outlined,
                          label: 'Time',
                          value: request['time']?.toString() ?? '-',
                        ),
                        _DetailRow(
                          icon: Icons.person_outline,
                          label: 'Requested By',
                          value: request['createdBy']?.toString() ?? '-',
                        ),
                        _DetailRow(
                          icon: Icons.location_on_outlined,
                          label: 'Address',
                          value: request['address']?.toString() ?? '-',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (attachments.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: _kBrandGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.attach_file_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Attachments',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF102A43),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: attachments.length,
                    itemBuilder: (context, index) {
                      final img = attachments[index].toString();
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: _kBrandGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.handyman_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Vendor Details',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF102A43),
                        ),
                      ),
                    ],
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
                        _DetailRow(
                          icon: Icons.person_outline,
                          label: 'Vendor',
                          value: vendorName.isEmpty ? 'Unassigned' : vendorName,
                        ),
                        if (request['vendorCompany'] != null &&
                            request['vendorCompany'].toString().isNotEmpty)
                          _DetailRow(
                            icon: Icons.business_outlined,
                            label: 'Company',
                            value: request['vendorCompany']?.toString() ?? '-',
                          ),
                        if (request['vendorContact'] != null &&
                            request['vendorContact'].toString().isNotEmpty)
                          _DetailRow(
                            icon: Icons.phone_outlined,
                            label: 'Contact',
                            value: request['vendorContact']?.toString() ?? '-',
                          ),
                        if (request['vendorEmail'] != null &&
                            request['vendorEmail'].toString().isNotEmpty)
                          _DetailRow(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: request['vendorEmail']?.toString() ?? '-',
                          ),
                      ],
                    ),
                  ),
                  if (isNewRequest && !showVendorDropdown)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: _kBrandGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.assignment_ind),
                            label: Text(
                              'Assign Vendor',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                showVendorDropdown = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  if (isNewRequest && showVendorDropdown)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Vendor',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF102A43),
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedVendor,
                            hint: Text(
                              'Choose a vendor',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            items:
                                vendors.map((vendor) {
                                  return DropdownMenuItem<String>(
                                    value: vendor['name'],
                                    child: Text(
                                      vendor['company'] ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 13),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedVendor = value;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD6E2F5),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD6E2F5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: _kBrandGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton.icon(
                                onPressed:
                                    selectedVendor == null
                                        ? null
                                        : () {
                                          final vendor = vendors.firstWhere(
                                            (v) => v['name'] == selectedVendor,
                                          );
                                          setState(() {
                                            widget.request['vendor'] =
                                                vendor['name'];
                                            widget.request['vendorCompany'] =
                                                vendor['company'];
                                            widget.request['vendorContact'] =
                                                vendor['contact'];
                                            widget.request['vendorEmail'] =
                                                vendor['email'];
                                            widget.request['status'] =
                                                'Pending';
                                            showVendorDropdown = false;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Vendor assigned successfully!',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          );
                                        },
                                icon: const Icon(Icons.check_circle_outline),
                                label: Text(
                                  'Confirm Assignment',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.grey.shade300,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTag extends StatelessWidget {
  final String text;

  const _QuickTag({required this.text});

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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
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
            width: 92,
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
