class Todo {
  String id;
  String description;
  String date;

  Todo({
    required this.id,
    required this.description,
  }) : date = DateTime.now()
            .toLocal()
            .toString()
            .split(' ')[0]; // Extract only the date

  // Convert a Todo to a Map
  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'date': date,
      };

  // Convert a Map to a Todo
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        description: json['description'],
      )..date = json['date'];
}
