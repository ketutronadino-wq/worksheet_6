import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';
import 'screens/home_page.dart';
import 'screens/courses_page.dart';
import 'screens/favorites_page.dart';
import 'screens/profile_page.dart';
import 'widgets/status_style.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(
        CourseRepository(CourseService()),
      )..loadAll(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer v2 - $studentId - $studentName',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveMainShell(),
    );
  }
}

class ResponsiveMainShell extends StatefulWidget {
  const ResponsiveMainShell({super.key});

  @override
  State<ResponsiveMainShell> createState() => _ResponsiveMainShellState();
}

class _ResponsiveMainShellState extends State<ResponsiveMainShell> {
  int _currentIndex = 0;

  void _selectPage(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    // ---------- LOADING ----------
    if (provider.isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Memuat data...'),
              SizedBox(height: 4),
              Text('$studentId - $studentName'),
            ],
          ),
        ),
      );
    }

    // ---------- ERROR ----------
    if (provider.error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  'Gagal memuat data: ${provider.error}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text('$studentId - $studentName'),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => context.read<CourseProvider>().loadAll(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ---------- DATA ----------
    final pages = <Widget>[
      const HomePage(),
      const CoursesPage(),
      const FavoritesPage(),
      const ProfilePage(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded =
            categoryFor(constraints.maxWidth) == LayoutCategory.expanded;

        return Scaffold(
          body: Row(
            children: [
              if (isExpanded) ...[
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _selectPage,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('Favorit'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
              ],
              Expanded(
                key: const ValueKey('page-area'),
                child: pages[_currentIndex],
              ),
            ],
          ),
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _selectPage,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: 'Favorit',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
        );
      },
    );
  }
}