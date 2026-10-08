import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/identity_banner.dart';
import '../widgets/status_style.dart';
import 'course_detail_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  bool _isOpening = false;

  Future<void> _openDetail(Course course) async {
    if (_isOpening) return;
    _isOpening = true;

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailPage(course: course),
      ),
    );

    _isOpening = false;
    if (!mounted || result == null) return;

    context.read<CourseProvider>().toggleFavorite(course.code);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result
            ? '${course.title} ditambahkan ke favorit'
            : '${course.title} dihapus dari favorit'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showQuickInfo(Course course) {
    final provider = context.read<CourseProvider>();
    final status = statusStyle(course.status);
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${course.code} • ${course.credits} SKS • ${status.label}'),
            const SizedBox(height: 8),
            Text(course.description),
            const SizedBox(height: 8),
            Text('${provider.student['nim']} - ${provider.student['name']}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final courses = provider.courses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mata Kuliah'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final cols = columnsFor(constraints.maxWidth);
          final category = categoryFor(constraints.maxWidth);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: IdentityBanner(student: provider.student),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${courses.length} mata kuliah • $cols kolom (${categoryLabel(category)})',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 176,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final isFav = provider.isFavorite(course.code);
                    return CourseCard(
                      course: course,
                      isFavorite: isFav,
                      onTap: () => _openDetail(course),
                      onLongPress: () => _showQuickInfo(course),
                      onToggleFavorite: () =>
                          context.read<CourseProvider>().toggleFavorite(course.code),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}