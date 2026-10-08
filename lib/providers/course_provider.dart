import 'package:flutter/foundation.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;
  CourseProvider(this.repository);

  List<Course> _courses = [];
  Map<String, dynamic> _student = {};
  bool _isLoading = false;
  String? _error;
  final Set<String> _favorites = {};

  List<Course> get courses => _courses;
  Map<String, dynamic> get student => _student;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Set<String> get favorites => _favorites;

  List<Course> get favoriteCourses =>
      _courses.where((c) => _favorites.contains(c.code)).toList();

  bool isFavorite(String code) => _favorites.contains(code);

  void toggleFavorite(String code) {
    if (_favorites.contains(code)) {
      _favorites.remove(code);
    } else {
      _favorites.add(code);
    }
    notifyListeners();
  }

  Future<void> loadAll() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final coursesFuture = repository.getCourses();
      final studentFuture = repository.getStudent();
      _courses = await coursesFuture;
      _student = await studentFuture;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}