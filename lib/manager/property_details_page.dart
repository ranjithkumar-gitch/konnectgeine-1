import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandPrimary = Color(0xFF2C5AA0);
const Color _kBrandSecondary = Color(0xFF1E3A8A);

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const PropertyDetailsPage({super.key, required this.property});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 720;
    final String propertyName = widget.property['name']?.toString() ?? '';
    final String propertyAddress = widget.property['address']?.toString() ?? '';
    final String propertyId = widget.property['id']?.toString() ?? 'N/A';
    final String unitCount = widget.property['units']?.toString() ?? '0';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        title: Text(
          propertyName.isEmpty ? 'Property Details' : propertyName,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                        'View Property Details',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Review complete property profile and configuration',
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
                  child: const Icon(Icons.domain_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailsSectionCard(
            title: 'Basic Property Information',
            child: _ResponsiveFields(
              isMobile: isMobile,
              children: [
                _ReadonlyField(label: 'Property ID', value: propertyId),
                _ReadonlyField(
                  label: 'Type',
                  value:
                      widget.property['type']?.toString() ?? 'Apartments/Condo',
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'Property Name',
                  value: propertyName.isEmpty ? '-' : propertyName,
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'Country',
                  value:
                      widget.property['country']?.toString() ?? 'United States',
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'State',
                  value: widget.property['state']?.toString() ?? 'Michigan',
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'City',
                  value:
                      widget.property['city']?.toString() ?? 'Madison Heights',
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'Address',
                  value: propertyAddress.isEmpty ? '-' : propertyAddress,
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'ZIP Code',
                  value: widget.property['zipCode']?.toString() ?? '48071',
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'Website',
                  value:
                      widget.property['website']?.toString() ??
                      'https://www.google.com/search?q=${propertyName.isEmpty ? 'property' : propertyName}',
                ),
                _ReadonlyField(
                  label: 'Status',
                  value: widget.property['status']?.toString() ?? 'Active',
                  requiredMark: true,
                ),
                _ReadonlyField(
                  label: 'Year Built',
                  value: widget.property['yearBuilt']?.toString() ?? '1969',
                ),
                _ReadonlyField(label: 'Units', value: unitCount),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailsSectionCard(
            title: 'Amenities',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ReadonlyField(
                  label: 'Select amenities',
                  value:
                      widget.property['amenities']?.toString() ??
                      'Gym, Parking, Security, Elevator',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.info_rounded,
                      size: 16,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Select one or more amenities for the property',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF627D98),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailsSectionCard(
            title: 'Contact Information',
            child: _ResponsiveFields(
              isMobile: isMobile,
              children: [
                _ReadonlyField(
                  label: 'Contact Person',
                  value:
                      widget.property['contactPerson']?.toString() ??
                      'Leasing Office - ${propertyName.isEmpty ? 'Property' : propertyName}',
                ),
                _ReadonlyField(
                  label: 'Contact Person Mobile',
                  value:
                      widget.property['contactMobile']?.toString() ??
                      '+1 2485557788',
                ),
                _ReadonlyField(
                  label: 'Contact Person Email',
                  value:
                      widget.property['contactEmail']?.toString() ??
                      'leasing@${(propertyName.isEmpty ? 'property' : propertyName).toLowerCase().replaceAll(' ', '')}.com',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailsSectionCard(
            title: 'Developer Information',
            child: Column(
              children: [
                _ResponsiveFields(
                  isMobile: isMobile,
                  children: [
                    _ReadonlyField(
                      label: 'Developer Name',
                      value:
                          widget.property['developerName']?.toString() ??
                          'Madison Heights Property Group LLC',
                    ),
                    _ReadonlyField(
                      label: 'Developer Email',
                      value:
                          widget.property['developerEmail']?.toString() ??
                          'info@mhpropertygroup.com',
                    ),
                    _ReadonlyField(
                      label: 'Developer Mobile',
                      value:
                          widget.property['developerMobile']?.toString() ??
                          '+1 2485551122',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _ReadonlyField(
                  label: 'Description',
                  value:
                      widget.property['description']?.toString() ??
                      'Premium managed property with strong occupancy, reliable service operations and modern amenities.',
                  maxLines: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DetailsSectionCard(
            title: 'Property Location',
            child: Column(
              children: [
                _ReadonlyField(
                  label: 'Address',
                  value: propertyAddress.isEmpty ? '-' : propertyAddress,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD9E2EC)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.pin_drop_rounded, color: _kBrandPrimary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Map preview is available in full property profile.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF486581),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _DetailsSectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _DetailsSectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border.all(color: const Color(0xFFD9E2EC)),
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF243B53),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }
}

class _ResponsiveFields extends StatelessWidget {
  final bool isMobile;
  final List<Widget> children;

  const _ResponsiveFields({required this.isMobile, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
            isMobile ? 1 : (constraints.maxWidth > 980 ? 3 : 2);
        final spacing = 12.0;
        final width =
            (constraints.maxWidth - ((crossAxisCount - 1) * spacing)) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: 14,
          children:
              children
                  .map((child) => SizedBox(width: width, child: child))
                  .toList(),
        );
      },
    );
  }
}

class _ReadonlyField extends StatelessWidget {
  final String label;
  final String value;
  final bool requiredMark;
  final int maxLines;

  const _ReadonlyField({
    required this.label,
    required this.value,
    this.requiredMark = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334E68),
                ),
              ),
              if (requiredMark)
                TextSpan(
                  text: ' *',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD9E2EC)),
          ),
          child: Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF334E68),
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
