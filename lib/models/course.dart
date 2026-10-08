class Course {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String description;

  Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'] as String,
      title: json['title'] as String,
      credits: (json['credits'] as num).toInt(),
      status: json['status'] as String,
      description: (json['description'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'title': title,
        'credits': credits,
        'status': status,
        'description': description,
      };
}