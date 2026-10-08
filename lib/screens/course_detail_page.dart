import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/identity_banner.dart';
import '../widgets/status_style.dart';

class CourseDetailPage extends StatefulWidget {
  final Course course;
  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late bool _favorite;

  @override
  void initState() {
    super.initState();
    _favorite = context.read<CourseProvider>().isFavorite(widget.course.code);
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final status = statusStyle(course.status);
    final student = context.read<CourseProvider>().student;

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IdentityBanner(student: student),
                const SizedBox(height: 16),
                Text(course.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      avatar: Icon(status.icon, color: status.color, size: 18),
                      label: Text(status.label),
                    ),
                    Chip(label: Text('Kode: ${course.code}')),
                    Chip(label: Text('${course.credits} SKS')),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Deskripsi',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(course.description,
                    style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() => _favorite = !_favorite);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_favorite
                                ? 'Ditandai sebagai favorit'
                                : 'Tanda favorit dilepas'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: Icon(
                        _favorite ? Icons.favorite : Icons.favorite_border,
                        color: _favorite ? Colors.red : null,
                      ),
                      label: Text(_favorite ? 'Disukai' : 'Sukai Kursus'),
                    ),
                    FilledButton.icon(
                      onPressed: () => Navigator.pop(context, _favorite),
                      icon: const Icon(Icons.check),
                      label: const Text('Simpan & Kembali'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}