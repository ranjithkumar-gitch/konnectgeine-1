import 'package:flutter/material.dart';

class ExpandableUnitCard extends StatefulWidget {
  final Map<String, String> unit;
  const ExpandableUnitCard({super.key, required this.unit});

  @override
  State<ExpandableUnitCard> createState() => _ExpandableUnitCardState();
}

class _ExpandableUnitCardState extends State<ExpandableUnitCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.amber.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),

      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          leading: const Icon(Icons.meeting_room, color: Colors.teal),
          title: Text('Unit ${widget.unit['unitNumber']}'),
          subtitle: Text('Floor: ${widget.unit['floor']}'),
          onExpansionChanged: (val) => setState(() => _expanded = val),
          collapsedBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo),
              title: Text('Tenant: ${widget.unit['tenant']}'),
              subtitle: Text('Phone: ${widget.unit['phone']}'),
            ),
          ],
        ),
      ),
    );
  }
}
