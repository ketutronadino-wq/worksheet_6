import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/identity_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final student = provider.student;
    final courses = provider.courses;

    final total = courses.length;
    final doneCount = courses.where((c) => c.status == 'done').length;
    final activeCount = courses.where((c) => c.status == 'active').length;
    final totalCredits = courses.fold<int>(0, (s, c) => s + c.credits);
    final skills = ((student['skills'] as List<dynamic>?) ?? const [])
        .map((e) => e.toString())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer - Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IdentityCard(student: student),
            const SectionTitle('Ringkasan Belajar'),
            Row(children: [
              Expanded(
                  child: StatCard(
                      icon: Icons.menu_book,
                      color: Colors.blue,
                      value: '$total',
                      label: 'Mata Kuliah')),
              const SizedBox(width: 12),
              Expanded(
                  child: StatCard(
                      icon: Icons.stars,
                      color: Colors.purple,
                      value: '$totalCredits',
                      label: 'Total SKS')),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              Expanded(
                  child: StatCard(
                      icon: Icons.check_circle,
                      color: Colors.green,
                      value: '$doneCount',
                      label: 'Selesai')),
              const SizedBox(width: 12),
              Expanded(
                  child: StatCard(
                      icon: Icons.hourglass_top,
                      color: Colors.orange,
                      value: '$activeCount',
                      label: 'Aktif')),
            ]),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$doneCount dari $total mata kuliah selesai'),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: total == 0 ? 0 : doneCount / total,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 18),
                      const SizedBox(width: 6),
                      Text('${provider.favorites.length} course favorit'),
                    ]),
                  ],
                ),
              ),
            ),
            const SectionTitle('Info Layar (MediaQuery)'),
            const _ScreenInfoPanel(),
            const SectionTitle('Skill Saya'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((s) => Chip(label: Text(s))).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ScreenInfoPanel extends StatelessWidget {
  const _ScreenInfoPanel();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final category = categoryFor(size.width);
    final simpleMode = size.width < 600 ? 'Compact' : 'Wide';
    final scheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Width: ${size.width.toStringAsFixed(0)}'),
                    Text('Height: ${size.height.toStringAsFixed(0)}'),
                    Text('Orientation: ${mq.orientation.name}'),
                    Text('Mode: $simpleMode'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              color: scheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category == LayoutCategory.compact
                          ? Icons.smartphone
                          : category == LayoutCategory.medium
                              ? Icons.tablet_mac
                              : Icons.desktop_windows,
                      color: scheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 6),
                    Text(categoryLabel(category),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: scheme.onPrimaryContainer)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}