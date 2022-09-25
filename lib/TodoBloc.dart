import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/TodoEvent.dart';
import 'package:todo_app/TodoItem.dart';
import 'package:todo_app/TodoProvider.dart';
import 'package:todo_app/TodoState.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  TodoProvider todoProvider = TodoProvider.instance;

  TodoBloc(): super(InitialTodoState()) {
    List<TodoItem> todos = [];

    on<AddTodoEvent>((event, emit) async {
      await todoProvider.insertTodo(TodoItem(event.id, event.title, event.notes, false));
    });

    on<UpdateTodoEvent>((event, emit) async {
      await todoProvider.updateTodo(event.item);
    });

    on<DeleteTodoEvent>((event, emit) async {
      await todoProvider.deleteTodo(event.item);
    });

    on<FetchTodoEvent>((event, emit) async {
      todos = await todoProvider.fetchTodos();
      emit(TodoListState(todos));
    });
  }

}