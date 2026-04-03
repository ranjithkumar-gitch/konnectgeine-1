import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const LinearGradient _kBrandGradient = LinearGradient(
  colors: [Color(0xFF2C5AA0), Color(0xFF1E3A8A)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _kBrandSecondary = Color(0xFF1E3A8A);

class ViewUserDetailsPage extends StatelessWidget {
  const ViewUserDetailsPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 720;
    final roles =
        (user['role'] ?? '-')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
    final statusColor =
        user['status'] == 'Active' ? Colors.green : Colors.orange;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: _kBrandGradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'View User Details',
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
          // ── Hero card ─────────────────────────────────────────────────
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 20 : 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['role'] ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.82),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.35),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    user['status'] ?? '-',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Basic Staff Information ───────────────────────────────────
          _SectionHeader(title: 'Basic Staff Information'),
          const SizedBox(height: 10),
          _SectionCard(
            children: [
              _isMobileGrid(isMobile, [
                // Profile image placeholder
                _FieldBlock(
                  label: 'Profile Image',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: isMobile ? 92 : 84,
                          height: isMobile ? 92 : 84,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFCBD5E1),
                              width: 1.4,
                            ),
                          ),
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 38,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No image',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Roles
                // _FieldBlock(
                //   label: 'Roles',
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 10,
                //       vertical: 10,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(color: Colors.grey.shade300),
                //     ),
                //     child: Wrap(
                //       spacing: 8,
                //       runSpacing: 8,
                //       children:
                //           roles.map((role) => _RoleChip(label: role)).toList(),
                //     ),
                //   ),
                // ),
              ]),
              const SizedBox(height: 14),
              _isMobileGrid(isMobile, [
                _TextField(label: 'Full Name', value: user['name'] ?? '-'),
                _TextField(label: 'Email', value: user['email'] ?? '-'),
                _TextField(label: 'Phone Number', value: user['phone'] ?? '-'),
              ]),
              const SizedBox(height: 14),
              _TextField(label: 'Status', value: user['status'] ?? '-'),
            ],
          ),
          const SizedBox(height: 20),

          // ── Address Information ────────────────────────────────────────
          _SectionHeader(title: 'Address Information'),
          const SizedBox(height: 10),
          _SectionCard(
            children: [
              _isMobileGrid(isMobile, [
                _TextField(
                  label: 'Country',
                  value: user['country'] ?? 'United States',
                ),
                _TextField(
                  label: 'State/Province',
                  value: user['state'] ?? 'Michigan',
                ),
                _TextField(
                  label: 'City',
                  value: user['city'] ?? 'Madison Heights',
                ),
              ]),
              const SizedBox(height: 14),
              _isMobileGrid(isMobile, [
                _TextField(
                  label: 'ZIP/Postal Code',
                  value: user['zip'] ?? '48071',
                ),
                _TextField(
                  label: 'Street Address',
                  value: user['street'] ?? 'Enter street address',
                  hint: true,
                ),
                _TextField(
                  label: 'Notes',
                  value: user['notes'] ?? 'Enter any additional notes',
                  hint: true,
                ),
              ]),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _isMobileGrid(bool isMobile, List<Widget> fields) {
    if (isMobile) {
      return Column(
        children:
            fields.expand((f) => [f, const SizedBox(height: 12)]).toList()
              ..removeLast(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          fields
              .expand((f) => [Expanded(child: f), const SizedBox(width: 14)])
              .toList()
            ..removeLast(),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF102A43),
      ),
    );
  }
}

// ── White section card ─────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
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
        children: children,
      ),
    );
  }
}

// ── Read-only text field block ─────────────────────────────────────────────────
class _TextField extends StatelessWidget {
  const _TextField({
    required this.label,
    required this.value,
    this.hint = false,
  });

  final String label;
  final String value;
  final bool hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF486581),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: hint ? const Color(0xFFF8FAFC) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: hint ? FontWeight.w400 : FontWeight.w500,
              color: hint ? Colors.grey.shade400 : const Color(0xFF102A43),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Generic content field block (label + custom child) ────────────────────────
class _FieldBlock extends StatelessWidget {
  const _FieldBlock({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF486581),
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

// ── Role chip ─────────────────────────────────────────────────────────────────
class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 34),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shield_rounded, size: 14, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
