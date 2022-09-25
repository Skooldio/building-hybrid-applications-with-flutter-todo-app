import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/TodoItem.dart';

class TodoProvider {
  static const TodoTable = "TodoItemTable";
  static TodoProvider instance = TodoProvider();

  Future<Database> database() async {
    return await openDatabase(join(await getDatabasesPath(), 'todo_item.db'),
        version: 1, onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE $TodoTable (id TEXT PRIMARY KEY, title TEXT, notes TEXT, done INTEGER)");
    });
  }

  Future<List<TodoItem>> fetchTodos() async {
    Database db = await database();
    List<Map<dynamic, dynamic>> todos = await db.query(TodoTable);

    return todos.map((e) => TodoItem.fromMap(e)).toList();
  }

  Future<void> insertTodo(TodoItem item) async {
    Database db = await database();
    await db.insert(TodoTable, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

}
