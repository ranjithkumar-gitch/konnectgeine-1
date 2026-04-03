import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class ManagerProfilePage extends StatelessWidget {
  const ManagerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

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
                color: const Color(0xFF1E3A8A).withOpacity(0.22),
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
                      'My Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Review your staff and address information',
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
                  Icons.account_circle_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _SectionCard(
          title: 'Basic User Information',
          children: [
            _ProfileImageAndRoleRow(),
            SizedBox(height: 14),
            _ThreeColFieldsRow(
              first: _ReadOnlyField(
                label: 'Property Manager Type',
                value: 'Company',
              ),
              second: _ReadOnlyField(
                label: 'Company/Organization *',
                value: 'North Bloomfield Properties',
              ),
              third: _ReadOnlyField(label: '', value: '', hidden: true),
            ),
            SizedBox(height: 14),
            _ThreeColFieldsRow(
              first: _ReadOnlyField(
                label: 'Full Name *',
                value: 'Kerry Grushoff',
              ),
              second: _ReadOnlyField(
                label: 'Email *',
                value: 'kerrygrushoff@yahoo.com',
              ),
              third: _ReadOnlyField(label: 'Phone Number', value: '2485439966'),
            ),
            SizedBox(height: 14),
            _ReadOnlyField(label: 'Status *', value: 'Active'),
          ],
        ),
        const SizedBox(height: 16),
        const _SectionCard(
          title: 'Address Information',
          children: [
            _ThreeColFieldsRow(
              first: _ReadOnlyField(
                label: 'Country',
                value: 'United States',
                hasDropdown: true,
              ),
              second: _ReadOnlyField(
                label: 'State/Province',
                value: 'Michigan',
                hasDropdown: true,
              ),
              third: _ReadOnlyField(label: 'City', value: 'Madison Heights'),
            ),
            SizedBox(height: 14),
            _ThreeColFieldsRow(
              first: _ReadOnlyField(label: 'ZIP/Postal Code', value: '48071'),
              second: _ReadOnlyField(
                label: 'Street Address',
                value: 'Enter street address',
                hint: true,
              ),
              third: _ReadOnlyField(
                label: 'Notes',
                value: 'Enter any additional notes',
                hint: true,
              ),
            ),
          ],
        ),
        if (isMobile) const SizedBox(height: 8),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

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
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _ProfileImageAndRoleRow extends StatelessWidget {
  const _ProfileImageAndRoleRow();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

    if (isMobile) {
      return Column(
        children: const [
          _ProfileImageField(),
          SizedBox(height: 14),
          _RoleField(),
        ],
      );
    }

    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _ProfileImageField()),
        SizedBox(width: 14),
        Expanded(flex: 2, child: _RoleField()),
      ],
    );
  }
}

class _ProfileImageField extends StatelessWidget {
  const _ProfileImageField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Image',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFD1D5DB),
              style: BorderStyle.solid,
              width: 1.4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_rounded, size: 36, color: Colors.grey.shade500),
              const SizedBox(height: 4),
              Text(
                'No image',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoleField extends StatelessWidget {
  const _RoleField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Roles *',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.badge_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Property Manager',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThreeColFieldsRow extends StatelessWidget {
  const _ThreeColFieldsRow({
    required this.first,
    required this.second,
    required this.third,
  });

  final Widget first;
  final Widget second;
  final Widget third;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;

    if (isMobile) {
      return Column(
        children: [
          first,
          const SizedBox(height: 12),
          second,
          const SizedBox(height: 12),
          third,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: first),
        const SizedBox(width: 14),
        Expanded(child: second),
        const SizedBox(width: 14),
        Expanded(child: third),
      ],
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({
    required this.label,
    required this.value,
    this.hasDropdown = false,
    this.hint = false,
    this.hidden = false,
  });

  final String label;
  final String value;
  final bool hasDropdown;
  final bool hint;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    if (hidden) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF374151),
            ),
          ),
        if (label.isNotEmpty) const SizedBox(height: 6),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 40),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: hint ? const Color(0xFFF8FAFC) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: hint ? FontWeight.w400 : FontWeight.w500,
                    color:
                        hint
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF102A43),
                  ),
                ),
              ),
              if (hasDropdown)
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: Color(0xFF6B7280),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
