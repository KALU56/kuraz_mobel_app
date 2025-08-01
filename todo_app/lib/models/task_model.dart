class Task {
  String id;
  String title;
  DateTime dueDate;
  bool isCompleted;
  DateTime? completedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.createNew({
    required String title,
    required DateTime dueDate,
  }) {
    final now = DateTime.now();
    return Task(
      id: now.millisecondsSinceEpoch.toString(),
      title: title,
      dueDate: dueDate,
      createdAt: now,
      updatedAt: now,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'],
      completedAt: map['completedAt'] != null ? DateTime.parse(map['completedAt']) : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}