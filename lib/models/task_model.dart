class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  String priority; // Could be 'High', 'Medium', 'Low', etc.

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  // Convert a Task object into a map to store in Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(), // Firebase uses strings for date
      'priority': priority,
    };
  }

  // Create a Task object from a map (for data retrieved from Firebase)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      priority: map['priority'] ?? '',
    );
  }
}
