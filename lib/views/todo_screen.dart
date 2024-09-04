import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_and_api_handeling_process/model/to_do_model.dart';

import '../providers/to_do_provider.dart';

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});
  final TextEditingController inputcontroller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: TextFormField(
                  controller: inputcontroller,
                  decoration: InputDecoration(
                    hintText: "Add TO DO ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onFieldSubmitted: (value) => {
                        ref.read(todoListProvider.notifier).addToDO(
                              TodoModel(
                                  id: Random().nextInt(9999),
                                  description: value,
                                  Completed: false),
                            ),
                        showSnackBar(context),
                        inputcontroller.text = "",
                      }),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer(builder: (context, WidgetRef ref, child) {
              final toDo = ref.watch(todoListProvider);
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: toDo.todoList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    toDo.todoList[index].description,
                    style: toDo.todoList[index].Completed
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                  trailing: Checkbox(
                      value: toDo.todoList[index].Completed,
                      onChanged: (value) => ref
                          .read(todoListProvider.notifier)
                          .toDoTogel(toDo.todoList[index].id, value!)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

showSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

const snackBar = SnackBar(
  content: Text("TODO Add Successfully"),
);
