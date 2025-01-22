class TodoModal {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;

  TodoModal({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  // Convert a TodoModal into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert a Map into a TodoModal
  factory TodoModal.fromMap(Map<String, dynamic> map) {
    return TodoModal(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
