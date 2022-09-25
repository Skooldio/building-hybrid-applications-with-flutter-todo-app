import 'package:flutter/material.dart';
import 'package:todo_app/TodoItem.dart';
import 'package:todo_app/TodoProvider.dart';
import 'package:uuid/uuid.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add todo")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(decoration: InputDecoration(labelText: "Title"), controller: _titleController,),
              TextField(decoration: InputDecoration(labelText: "Description"), controller: _notesController,),
              ElevatedButton(onPressed: () async {
                var todo = TodoItem(Uuid().v4(), _titleController.text, _notesController.text, false);
                await TodoProvider.instance.insertTodo(todo);
                if(!mounted) return;
                closePage(context);
              }, child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }

  void closePage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
