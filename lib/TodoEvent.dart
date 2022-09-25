import 'package:todo_app/TodoItem.dart';

abstract class TodoEvent {
  TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  String id;
  String title;
  String notes;

  AddTodoEvent(this.id, this.title, this.notes);
}

class UpdateTodoEvent extends TodoEvent {
  TodoItem item;
  UpdateTodoEvent(this.item);
}

class DeleteTodoEvent extends TodoEvent {
  TodoItem item;
  DeleteTodoEvent(this.item);
}

class FetchTodoEvent extends TodoEvent {
  FetchTodoEvent();
}
