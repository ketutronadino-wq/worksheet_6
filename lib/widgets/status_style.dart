import 'package:flutter/material.dart';

const String studentName = 'Ketut Rona Dino';
const String studentId = '2415051108';

enum LayoutCategory { compact, medium, expanded }

LayoutCategory categoryFor(double width) {
  if (width < 600) return LayoutCategory.compact;
  if (width < 840) return LayoutCategory.medium;
  return LayoutCategory.expanded;
}

String categoryLabel(LayoutCategory c) {
  switch (c) {
    case LayoutCategory.compact:
      return 'Compact';
    case LayoutCategory.medium:
      return 'Medium';
    case LayoutCategory.expanded:
      return 'Expanded';
  }
}

int columnsFor(double width) {
  if (width < 600) return 1;
  if (width < 840) return 2;
  return 3;
}

class StatusStyle {
  final String label;
  final IconData icon;
  final Color color;
  const StatusStyle(this.label, this.icon, this.color);
}

StatusStyle statusStyle(String status) {
  switch (status) {
    case 'done':
      return const StatusStyle('Selesai', Icons.check_circle, Colors.green);
    case 'active':
      return const StatusStyle('Aktif', Icons.hourglass_top, Colors.orange);
    default:
      return const StatusStyle('Direncanakan', Icons.schedule, Colors.blueGrey);
  }
}