// // lib/models/user_model.dart
// class Todomodel {
//   final int id;
//   final String description;
//   final bool completed;

//   Todomodel({
//     required this.id,
//     required this.description,
//     required this.completed,
//   });

//   factory Todomodel.fromJson(Map<String, dynamic> json) {
//     return Todomodel(
//       id: json['id'],
//       description: json['description'],
//       completed: json['completed'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'description': description,
//       'completed': completed,
//     };
//   }
// }

class TodoModel {
  final int id;
  final bool Completed;
  final String description;

  TodoModel(
      {required this.id, required this.Completed, required this.description});

  TodoModel copyWith({int? id, bool? Completed, String? description}) {
    return TodoModel(
      id: id ?? this.id,
      Completed: Completed ?? this.Completed,
      description: description ?? this.description,
    );
  }
}
