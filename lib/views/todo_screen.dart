import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo_model.dart';
import '../view_model/todo_view_model.dart';

class TodoScreen extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoViewModel = ref.watch(todoViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter To-Do',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        todoViewModel.addTodo(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  todoViewModel.addTodo(value);
                  _controller.clear();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoViewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = todoViewModel.todos[index];
                return ListTile(
                  title: Text(todo.description),
                  subtitle: Text(
                    todo.id,
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    width: 99,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () =>
                              _showEditDialog(context, todoViewModel, todo),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              todoViewModel.removeTodoById(todo.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, TodoViewModel todoViewModel, Todo todo) {
    final TextEditingController _editController =
        TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit To-Do'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              hintText: 'Enter new to-do',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                todoViewModel.editTodo(todo.id, _editController.text);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
