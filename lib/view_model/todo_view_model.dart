import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/todo_model.dart';

final todoViewModelProvider = ChangeNotifierProvider((ref) => TodoViewModel());

class TodoViewModel extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodoViewModel() {
    _loadTodos();
  }

  // Load the to-dos from SharedPreferences
  Future<void> _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('');
    if (todosString != null) {
      final List decodedList = json.decode(todosString) as List;
      _todos = decodedList.map((item) => Todo.fromJson(item)).toList();
    }
    notifyListeners();
  }

  // Save the to-dos to SharedPreferences
  Future<void> _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _todos.map((todo) => todo.toJson()).toList(),
    );
    await prefs.setString('todos', encodedData);
  }

  // Add a new to-do
  void addTodo(String description) {
    _todos.add(Todo(
      id: DateTime.now().toString(),
      description: description,
    ));
    _saveTodos();
    notifyListeners();
  }

  // Edit an existing to-do
  void editTodo(String id, String newDescription) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = Todo(
        id: _todos[index].id,
        description: newDescription,
      );
      _saveTodos();
      notifyListeners();
    }
  }

  // Remove a to-do by ID
  void removeTodoById(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _saveTodos();
    notifyListeners();
  }
}
