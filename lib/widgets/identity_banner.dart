import 'package:flutter/material.dart';
import 'status_style.dart';

class IdentityBanner extends StatelessWidget {
  final Map<String, dynamic> student;
  const IdentityBanner({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final name = (student['name'] ?? studentName).toString();
    final nim = (student['nim'] ?? studentId).toString();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.badge, color: scheme.onPrimaryContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text('$nim - $name',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: scheme.onPrimaryContainer)),
          ),
        ],
      ),
    );
  }
}