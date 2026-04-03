import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String _dateLabel() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final now = DateTime.now();
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final metrics = [
      const _MetricData(
        title: 'Properties',
        value: '1',
        subtitle: 'Managed assets',
        icon: Icons.apartment_rounded,
        color: Color(0xFF2563EB),
        chipLabel: '+0%',
        progress: 0.35,
      ),
      const _MetricData(
        title: 'Units',
        value: '2',
        subtitle: 'Total inventory',
        icon: Icons.grid_view_rounded,
        color: Color(0xFF0F766E),
        chipLabel: '+3%',
        progress: 0.54,
      ),
      const _MetricData(
        title: 'New SR',
        value: '1',
        subtitle: 'Awaiting action',
        icon: Icons.markunread_mailbox_rounded,
        color: Color(0xFF4F46E5),
        chipLabel: 'Live',
        progress: 0.42,
      ),
      const _MetricData(
        title: 'Inprogress',
        value: '1',
        subtitle: 'Ongoing work',
        icon: Icons.construction_rounded,
        color: Color(0xFFF59E0B),
        chipLabel: 'Active',
        progress: 0.58,
      ),
      const _MetricData(
        title: 'Completed',
        value: '1',
        subtitle: 'Closed this cycle',
        icon: Icons.task_alt_rounded,
        color: Color(0xFF16A34A),
        chipLabel: 'Done',
        progress: 0.72,
      ),
      const _MetricData(
        title: 'Overdue',
        value: '1',
        subtitle: 'Past SLA',
        icon: Icons.warning_amber_rounded,
        color: Color(0xFFDC2626),
        chipLabel: 'Urgent',
        progress: 0.88,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isCompact = width < 720;
        final metricColumns =
            width >= 1280
                ? 3
                : width >= 900
                ? 3
                : width >= 640
                ? 2
                : 1;
        final metricHeight = width < 420 ? 210.0 : 196.0;

        return ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            20 + kBottomNavigationBarHeight,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E40AF), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E40AF).withOpacity(0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child:
                  isCompact
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeroText(),
                          const SizedBox(height: 16),
                          _buildHeroBadge(),
                        ],
                      )
                      : Row(
                        children: [
                          Expanded(child: _buildHeroText()),
                          const SizedBox(width: 16),
                          _buildHeroBadge(),
                        ],
                      ),
            ),
            const SizedBox(height: 18),
            isCompact
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreetingRow(),
                    const SizedBox(height: 14),
                    _buildOverdueAlert(compact: true),
                  ],
                )
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildGreetingRow()),
                    const SizedBox(width: 14),
                    SizedBox(
                      width: 320,
                      child: _buildOverdueAlert(compact: false),
                    ),
                  ],
                ),
            const SizedBox(height: 18),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: metrics.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: metricColumns,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                mainAxisExtent: metricHeight,
              ),
              itemBuilder:
                  (context, index) => _MetricCard(data: metrics[index]),
            ),
            const SizedBox(height: 18),
            _PanelCard(
              title: 'Service Overview',
              actionLabel: 'This month',
              child:
                  isCompact
                      ? Column(
                        children: const [
                          _MiniStatBlock(
                            label: 'Resolution Rate',
                            value: '100%',
                            color: Color(0xFF16A34A),
                          ),
                          SizedBox(height: 10),
                          _MiniStatBlock(
                            label: 'Avg Response',
                            value: '2.4 hrs',
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(height: 10),
                          _MiniStatBlock(
                            label: 'Properties Covered',
                            value: '1',
                            color: Color(0xFF7C3AED),
                          ),
                        ],
                      )
                      : const Row(
                        children: [
                          Expanded(
                            child: _MiniStatBlock(
                              label: 'Resolution Rate',
                              value: '100%',
                              color: Color(0xFF16A34A),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _MiniStatBlock(
                              label: 'Avg Response',
                              value: '2.4 hrs',
                              color: Color(0xFF2563EB),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _MiniStatBlock(
                              label: 'Properties Covered',
                              value: '1',
                              color: Color(0xFF7C3AED),
                            ),
                          ),
                        ],
                      ),
            ),
            const SizedBox(height: 16),
            _PanelCard(
              title: 'Recent Activity',
              actionLabel: 'Latest updates',
              child: Column(
                children: const [
                  _ActivityItem(
                    title: 'Service request created',
                    subtitle: 'SR-1024 was raised for plumbing maintenance.',
                    time: '10 mins ago',
                    color: Color(0xFF2563EB),
                  ),
                  SizedBox(height: 12),
                  _ActivityItem(
                    title: 'Work order completed',
                    subtitle: 'Electrical inspection was marked as resolved.',
                    time: '1 hr ago',
                    color: Color(0xFF16A34A),
                  ),
                  SizedBox(height: 12),
                  _ActivityItem(
                    title: 'Overdue case escalated',
                    subtitle: 'Cleaning request exceeded the expected SLA.',
                    time: 'Today',
                    color: Color(0xFFDC2626),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _PanelCard(
              title: 'Users Overview',
              actionLabel: 'Active profiles',
              child: Column(
                children: const [
                  _UserRow(
                    label: 'Owners',
                    value: '1',
                    icon: Icons.person_rounded,
                    color: Color(0xFF2563EB),
                  ),
                  SizedBox(height: 10),
                  _UserRow(
                    label: 'Tenants',
                    value: '0',
                    icon: Icons.groups_2_rounded,
                    color: Color(0xFF0F766E),
                  ),
                  SizedBox(height: 10),
                  _UserRow(
                    label: 'Vendors',
                    value: '0',
                    icon: Icons.handyman_rounded,
                    color: Color(0xFF7C3AED),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _PanelCard(
              title: 'Quick Actions',
              actionLabel: 'Manager shortcuts',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _QuickActionTile(
                    title: 'Properties',
                    subtitle: 'View managed assets',
                    icon: Icons.apartment_rounded,
                    color: Color(0xFF2563EB),
                  ),
                  _QuickActionTile(
                    title: 'Units',
                    subtitle: 'Inspect unit inventory',
                    icon: Icons.grid_view_rounded,
                    color: Color(0xFF0F766E),
                  ),
                  _QuickActionTile(
                    title: 'All SRs',
                    subtitle: 'Track active tickets',
                    icon: Icons.assignment_rounded,
                    color: Color(0xFFF59E0B),
                  ),
                  _QuickActionTile(
                    title: 'Profile',
                    subtitle: 'Review your details',
                    icon: Icons.person_outline_rounded,
                    color: Color(0xFF7C3AED),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _PanelCard(
              title: 'SRs by Priority',
              actionLabel: 'Open tickets',
              child: Column(
                children: const [
                  _PriorityRow(
                    label: 'Low',
                    count: '0',
                    color: Color(0xFF60A5FA),
                    progress: 0.08,
                  ),
                  SizedBox(height: 12),
                  _PriorityRow(
                    label: 'Medium',
                    count: '2',
                    color: Color(0xFFF59E0B),
                    progress: 0.56,
                  ),
                  SizedBox(height: 12),
                  _PriorityRow(
                    label: 'Urgent',
                    count: '0',
                    color: Color(0xFFEF4444),
                    progress: 0.10,
                  ),
                  SizedBox(height: 12),
                  _PriorityRow(
                    label: 'Overdue',
                    count: '1',
                    color: Color(0xFFB91C1C),
                    progress: 0.78,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _PanelCard(
              title: 'Active Service Requests',
              actionLabel: '3 open items',
              child: Column(
                children: const [
                  _RequestRow(
                    id: 'SR-1024',
                    issue: 'Plumbing leak in Unit A-204',
                    property: 'Sunrise Residency',
                    status: 'New',
                    priority: 'Medium',
                    assignee: 'Unassigned',
                  ),
                  SizedBox(height: 12),
                  _RequestRow(
                    id: 'SR-1021',
                    issue: 'Electrical panel inspection',
                    property: 'Sunrise Residency',
                    status: 'Inprogress',
                    priority: 'Medium',
                    assignee: 'Vendor Team',
                  ),
                  SizedBox(height: 12),
                  _RequestRow(
                    id: 'SR-1012',
                    issue: 'Deep cleaning completion overdue',
                    property: 'Sunrise Residency',
                    status: 'Overdue',
                    priority: 'High',
                    assignee: 'Facility Crew',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manager Dashboard',
          style: GoogleFonts.poppins(
            fontSize: 26,
            height: 1.1,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track portfolio health, monitor service requests and keep daily operations moving.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.45,
            color: Colors.white.withOpacity(0.86),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_graph_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            'Live operational view',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_greeting()}, Manager',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _dateLabel(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverdueAlert({required bool compact}) {
    final content =
        compact
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.error_outline_rounded,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '1 overdue service request needs attention.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF991B1B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildAlertChip(),
              ],
            )
            : Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '1 overdue service request needs attention.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF991B1B),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildAlertChip(),
              ],
            );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: content,
    );
  }

  Widget _buildAlertChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDC2626),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Review now',
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({
    required this.title,
    required this.child,
    this.actionLabel,
  });

  final String title;
  final String? actionLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              if (actionLabel != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    actionLabel!,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _MetricData {
  const _MetricData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.chipLabel,
    required this.progress,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String chipLabel;
  final double progress;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final _MetricData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, color: data.color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.value,
            style: GoogleFonts.poppins(
              fontSize: 30,
              height: 1,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: data.progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(data.color),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                data.chipLabel,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: data.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatBlock extends StatelessWidget {
  const _MiniStatBlock({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.bolt_rounded, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  height: 1.45,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
}

class _UserRow extends StatelessWidget {
  const _UserRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        final tileWidth =
            width >= 1100
                ? (width - 92) / 4
                : width >= 760
                ? (width - 80) / 2
                : double.infinity;

        return SizedBox(
          width: tileWidth,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          height: 1.4,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PriorityRow extends StatelessWidget {
  const _PriorityRow({
    required this.label,
    required this.count,
    required this.color,
    required this.progress,
  });

  final String label;
  final String count;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _RequestRow extends StatelessWidget {
  const _RequestRow({
    required this.id,
    required this.issue,
    required this.property,
    required this.status,
    required this.priority,
    required this.assignee,
  });

  final String id;
  final String issue;
  final String property;
  final String status;
  final String priority;
  final String assignee;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 720;

    final statusColor = switch (status) {
      'New' => const Color(0xFF2563EB),
      'Inprogress' => const Color(0xFFF59E0B),
      'Overdue' => const Color(0xFFDC2626),
      _ => const Color(0xFF64748B),
    };

    final priorityColor = switch (priority) {
      'High' => const Color(0xFFDC2626),
      'Medium' => const Color(0xFFF59E0B),
      _ => const Color(0xFF2563EB),
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child:
          isCompact
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    id,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    issue,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    property,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _TinyChip(label: status, color: statusColor),
                      _TinyChip(label: priority, color: priorityColor),
                      _TinyChip(
                        label: assignee,
                        color: const Color(0xFF475569),
                      ),
                    ],
                  ),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 72,
                    child: Text(
                      id,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          issue,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _TinyChip(label: status, color: statusColor),
                  const SizedBox(width: 8),
                  _TinyChip(label: priority, color: priorityColor),
                  const SizedBox(width: 8),
                  _TinyChip(label: assignee, color: const Color(0xFF475569)),
                ],
              ),
    );
  }
}

class _TinyChip extends StatelessWidget {
  const _TinyChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
