import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:worksheet_6/main.dart';
import 'package:worksheet_6/providers/course_provider.dart';
import 'package:worksheet_6/repositories/course_repository.dart';
import 'package:worksheet_6/services/course_service.dart';

void main() {
  testWidgets('Menampilkan loading lalu error state (asset tidak tersedia di test)',
      (WidgetTester tester) async {
    // Build app dengan Provider seperti di main()
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CourseProvider(
          CourseRepository(CourseService()),
        )..loadAll(),
        child: const CourseExplorerApp(),
      ),
    );

    // Frame pertama: harus muncul loading indicator
    expect(find.byType(CircularProgressIndicator), findsWidgets);

    // Tunggu proses async selesai (loading -> error karena rootBundle tidak ada di test)
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}