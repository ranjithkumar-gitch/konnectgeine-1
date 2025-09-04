import 'package:flutter/material.dart';

class RequestDetailsPage extends StatefulWidget {
  final Map<String, dynamic> request;
  const RequestDetailsPage({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  bool showVendorDropdown = false;
  String? selectedVendor;

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
    // Default vendor list
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
    return Scaffold(
      appBar: AppBar(title: const Text('Request Details')),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.confirmation_number,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'ID: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          Text(
                            request['id'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              request['status'] == 'Completed'
                                  ? Colors.green.shade100
                                  : request['status'] == 'Pending'
                                  ? Colors.orange.shade100
                                  : request['status'] == 'In Progress'
                                  ? Colors.blue.shade100
                                  : request['status'] == 'New'
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          request['status'],
                          style: TextStyle(
                            color:
                                request['status'] == 'Completed'
                                    ? Colors.green.shade800
                                    : request['status'] == 'Pending'
                                    ? Colors.orange.shade800
                                    : request['status'] == 'In Progress'
                                    ? Colors.blue.shade800
                                    : request['status'] == 'New'
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.title, color: Colors.amber.shade700),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          request['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.description, color: Colors.grey.shade700),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          request['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.teal.shade700),
                      const SizedBox(width: 10),
                      Text(
                        'Requested On: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      Text(
                        request['date'],
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        request['time'],
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.deepOrange.shade700),
                      const SizedBox(width: 10),
                      Text(
                        'Requested By: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange.shade700,
                        ),
                      ),
                      Text(
                        request['createdBy'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Colors.redAccent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          request['address'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Attachments grid above vendor card
          if (request['attachments'] != null &&
              request['attachments'] is List &&
              request['attachments'].isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attachments',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: request['attachments'].length,
                    itemBuilder: (context, index) {
                      final img = request['attachments'][index];
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
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.handyman, color: Colors.teal.shade700),
                      const SizedBox(width: 10),
                      Text(
                        'Assigned Vendor: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          request['vendor'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (request['vendorCompany'] != null &&
                      request['vendorCompany'].toString().isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.business, color: Colors.indigo.shade700),
                        const SizedBox(width: 10),
                        Text(
                          'Company: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo.shade700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            request['vendorCompany'],
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  if (request['vendorContact'] != null &&
                      request['vendorContact'].toString().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.phone, color: Colors.green.shade700),
                          const SizedBox(width: 10),
                          Text(
                            'Contact: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              request['vendorContact'],
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (request['vendorEmail'] != null &&
                      request['vendorEmail'].toString().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.email, color: Colors.deepPurple.shade700),
                          const SizedBox(width: 10),
                          Text(
                            'Email: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple.shade700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              request['vendorEmail'],
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isNewRequest && !showVendorDropdown)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.assignment_ind),
                          label: const Text('Assign Vendor'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
                  if (isNewRequest && showVendorDropdown)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Vendor:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedVendor,
                            hint: const Text('Select vendor'),
                            items:
                                vendors.map((vendor) {
                                  return DropdownMenuItem<String>(
                                    value: vendor['name'],
                                    child: Text(
                                      '${vendor['company']}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedVendor = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
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
                                          widget.request['status'] = 'Pending';
                                          showVendorDropdown = false;
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Vendor assigned successfully!',
                                            ),
                                          ),
                                        );
                                      },
                              icon: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                              label: const Text('Confirm Assignment'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF4F8FFF,
                                ), // Modern blue
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 16,
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                elevation: 3,
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
