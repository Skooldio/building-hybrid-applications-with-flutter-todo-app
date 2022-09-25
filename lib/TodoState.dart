import 'package:todo_app/TodoItem.dart';

abstract class TodoState {
  TodoState();
}

class InitialTodoState extends TodoState {

}

class TodoListState extends TodoState {
  List<TodoItem> todos;

  TodoListState(this.todos);
}

