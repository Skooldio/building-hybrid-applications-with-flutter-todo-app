import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
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
              TextField(decoration: InputDecoration(labelText: "Title"),),
              TextField(decoration: InputDecoration(labelText: "Description"),),
              ElevatedButton(onPressed: () {
                //TODO: Add todo item
                Navigator.of(context).pop();
              }, child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
