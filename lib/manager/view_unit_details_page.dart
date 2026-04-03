import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ViewUnitDetailsPage extends StatelessWidget {
  const ViewUnitDetailsPage({super.key, required this.unit});

  final Map<String, dynamic> unit;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 720;
    final unitId = unit['id']?.toString() ?? 'U20264';
    final propertyName = unit['property']?.toString() ?? 'Stephenson House';
    final unitNo = unit['unitNo']?.toString() ?? 'S-509';
    final occupancy = unit['occupancy']?.toString() ?? 'Vacant for Rent';
    final status = unit['status']?.toString() ?? 'Active';
    final unitType = _deriveUnitType(unitNo);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'View Unit Details ',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + (isMobile ? 12 : 20)),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stephenson House',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 22 : 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Review complete unit profile and location details',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          height: 1.3,
                          color: Colors.white.withOpacity(0.82),
                        ),
                      ),
                    ],
                  ),
                ),
                // _BackButton(isMobile: isMobile),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _TinyStatusChip(
                  label: occupancy.toUpperCase().replaceAll(' ', '-'),
                  dotColor: Colors.black,
                ),
                _UnitTypeChip(label: unitType),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailSectionCard(
            title: 'Basic Unit Information',
            child: _ResponsiveFormGrid(
              children: [
                _FieldData(label: 'Unit ID', value: unitId, required: true),
                _FieldData(
                  label: 'Property Name',
                  value: '20267 - $propertyName ( Madison Heights )',
                  required: true,
                  hasDropdown: true,
                ),
                const _FieldData(
                  label: 'Property Group',
                  value: 'Select Property Group',
                  hasDropdown: true,
                ),
                _FieldData(label: 'Unit Number', value: unitNo, required: true),
                _FieldData(
                  label: 'Unit Type',
                  value: unitType,
                  hasDropdown: true,
                ),
                const _FieldData(label: 'Block', value: '3'),
                const _FieldData(label: 'Floor', value: '3'),
                _FieldData(
                  label: 'Is Occupied',
                  value: occupancy,
                  required: true,
                  hasDropdown: true,
                ),
                const _FieldData(
                  label: 'Owner Name',
                  value: 'Emily Carter',
                  hasDropdown: true,
                ),
                const _FieldData(
                  label: 'Property Manager',
                  value: 'Kerry Grushoff',
                  hasDropdown: true,
                ),
                _FieldData(
                  label: 'Status',
                  value: status,
                  required: true,
                  hasDropdown: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailSectionCard(
            title: 'Location Information',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_box,
                        color: Color(0xFFD1D5DB),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Use Property Address Details',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF374151),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Check this to auto populate from selected property',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _ResponsiveFormGrid(
                  children: const [
                    _FieldData(
                      label: 'Country',
                      value: 'United States',
                      hasDropdown: true,
                    ),
                    _FieldData(
                      label: 'State',
                      value: 'Michigan',
                      hasDropdown: true,
                    ),
                    _FieldData(
                      label: 'City',
                      value: 'Madison Heights',
                      required: true,
                    ),
                    _FieldData(
                      label: 'ZIP/Postal Code',
                      value: '48071',
                      required: true,
                    ),
                    _FieldData(
                      label: 'Address',
                      value: '27700 Stephenson Hwy',
                      required: true,
                      multiline: true,
                      fullWidth: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DetailSectionCard(
            title: 'Unit Details',
            child: _ResponsiveFormGrid(
              children: const [
                _FieldData(label: 'Size', value: '2000'),
                _FieldData(label: 'Facing', value: 'South', hasDropdown: true),
                _FieldData(label: 'Price', value: '1990', prefix: '\$'),
                _FieldData(
                  label: 'Description',
                  value: 'Enter Description',
                  multiline: true,
                  fullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _deriveUnitType(String unitNo) {
    if (unitNo.startsWith('S-5')) {
      return '1BHK';
    }
    return '2BHK';
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => Navigator.of(context).pop(),
      style: OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12,
          vertical: isMobile ? 8 : 10,
        ),
        side: BorderSide(color: Colors.white.withOpacity(0.4)),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Icon(Icons.arrow_back, size: isMobile ? 16 : 18),
      label: Text(
        isMobile ? 'Back' : 'Back to Units',
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 12 : 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TinyStatusChip extends StatelessWidget {
  const _TinyStatusChip({required this.label, required this.dotColor});

  final String label;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 9, color: dotColor),
          const SizedBox(width: 7),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitTypeChip extends StatelessWidget {
  const _UnitTypeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFE0ECFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.home_rounded, size: 14, color: Color(0xFF1D72D8)),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1D72D8),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSectionCard extends StatelessWidget {
  const _DetailSectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }
}

class _ResponsiveFormGrid extends StatelessWidget {
  const _ResponsiveFormGrid({required this.children});

  final List<_FieldData> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final columns = maxWidth >= 980 ? 2 : 1;
        const spacing = 12.0;
        final fieldWidth =
            columns == 1
                ? maxWidth
                : (maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children:
              children.map((field) {
                final width = field.fullWidth ? maxWidth : fieldWidth;
                return SizedBox(
                  width: width,
                  child: _ReadOnlyField(data: field),
                );
              }).toList(),
        );
      },
    );
  }
}

class _FieldData {
  const _FieldData({
    required this.label,
    required this.value,
    this.required = false,
    this.hasDropdown = false,
    this.multiline = false,
    this.fullWidth = false,
    this.prefix,
  });

  final String label;
  final String value;
  final bool required;
  final bool hasDropdown;
  final bool multiline;
  final bool fullWidth;
  final String? prefix;
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({required this.data});

  final _FieldData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: data.label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF374151),
            ),
            children: [
              if (data.required)
                TextSpan(
                  text: ' *',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFDC2626),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          constraints: BoxConstraints(minHeight: data.multiline ? 72 : 42),
          padding: EdgeInsets.symmetric(
            horizontal: 11,
            vertical: data.multiline ? 11 : 9,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            crossAxisAlignment:
                data.multiline
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            children: [
              if (data.prefix != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    data.prefix!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                Container(width: 1, height: 22, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  data.value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4B5563),
                  ),
                ),
              ),
              if (data.hasDropdown)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
