import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/TodoBloc.dart';
import 'package:todo_app/TodoEvent.dart';
import 'package:todo_app/TodoItem.dart';
import 'package:todo_app/TodoProvider.dart';
import 'package:todo_app/TodoState.dart';
import 'package:todo_app/add_todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TodoBloc())],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.orange,
              textTheme: GoogleFonts.latoTextTheme(),
              appBarTheme:
                  const AppBarTheme(foregroundColor: Color(0xFFFFFFFF))),
          home: const MyHomePage(title: "My Todo app"),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoProvider todoProvider = TodoProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is InitialTodoState) {
            context.read<TodoBloc>().add(FetchTodoEvent());
          }
          if (state is TodoListState) {
            var items = state.todos;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var todoItem = items[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(),
                    secondaryBackground: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        todoProvider.deleteTodo(todoItem);
                      });
                    },
                    child: ListTile(
                      title: Text(todoItem.title),
                      subtitle: Text(todoItem.notes),
                      leading: Checkbox(
                        value: todoItem.done,
                        onChanged: (value) =>
                            _onCheckValueChanged(value ?? false, todoItem),
                      ),
                    ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabClicked,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onFabClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddTodoPage()))
        .then((value) {
      setState(() {});
    });
  }

  void _onCheckValueChanged(bool isChecked, TodoItem item) async {
    TodoItem newItem = TodoItem(item.id, item.title, item.notes, isChecked);
    await todoProvider.updateTodo(newItem);
    setState(() {});
  }

  Future<List<TodoItem>> _fetchTodos() async {
    return await todoProvider.fetchTodos();
  }
}
