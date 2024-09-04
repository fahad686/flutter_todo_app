import 'package:flutter/foundation.dart';
import '../model/to_do_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoList with ChangeNotifier {
  List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => _todoList;

  void addToDO(TodoModel todoModel) {
    _todoList = [todoModel, ...todoList];
    notifyListeners();
  }

  void removeTodo(TodoModel todoModel) {
    _todoList.remove(todoModel);
    notifyListeners();
  }

  void toDoTogel(int id, bool isCompleted) {
    _todoList = [
      for (final toDo in todoList)
        if (toDo.id == id) toDo.copyWith(Completed: isCompleted) else toDo,
    ];
    notifyListeners();
  }
}

final todoListProvider = ChangeNotifierProvider((ref) => TodoList());
