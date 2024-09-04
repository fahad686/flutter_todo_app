import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController(text: "");
  TextEditingController _editController = TextEditingController();

  List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  // Load the saved to-do list from SharedPreferences
  _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('todos') ?? [];
    });
  }

  // Save the to-do list to SharedPreferences
  _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todos', todoList);
  }

  // Add a new to-do
  _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        todoList.add(_controller.text);
        _saveTodos();
        _controller.clear();
      });
    }
  }

  // Remove a to-do by index
  _removeTodoAt(int index) {
    setState(() {
      todoList.removeAt(index);
      _saveTodos();
    });
  }

  // Function to edit a to-do
  _editTodoAt(int index) {
    _editController.text = todoList[index];
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
                setState(() {
                  todoList[index] = _editController.text;
                  _saveTodos();
                });
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter To-Do',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: Text('Add To-Do'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todoList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeTodoAt(index),
                  ),
                  onLongPress: () => _editTodoAt(index), // Edit on long press
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
