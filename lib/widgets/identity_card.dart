import 'package:flutter/material.dart';
import 'profile_avatar.dart';
import 'status_style.dart';

class IdentityCard extends StatelessWidget {
  final Map<String, dynamic> student;
  const IdentityCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final name = (student['name'] ?? studentName).toString();
    final nim = (student['nim'] ?? studentId).toString();

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const ProfileAvatar(radius: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('NIM: $nim', style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.phone_android, size: 18),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text('Mobile Programming Student',
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}