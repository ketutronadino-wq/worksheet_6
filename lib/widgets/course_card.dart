import 'package:flutter/material.dart';
import '../models/course.dart';
import 'status_style.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onToggleFavorite;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onTap,
    required this.onLongPress,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final status = statusStyle(course.status);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(status.icon, color: status.color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(course.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    onPressed: onToggleFavorite,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 22,
                    tooltip: isFavorite ? 'Hapus favorit' : 'Tambah favorit',
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('${course.code} • ${course.credits} SKS'),
              const SizedBox(height: 6),
              Expanded(
                child: Text(course.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall),
              ),
              Text(status.label,
                  style: TextStyle(
                      color: status.color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}