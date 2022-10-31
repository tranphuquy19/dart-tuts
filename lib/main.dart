import 'package:firstapp/app_settings.dart';
import 'package:firstapp/todo.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() => runApp(ChangeNotifierProvider(
//       create: (context) => ToDoProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         routes: {
//           '/': (context) => ToDoScreen(),
//           '/second': (context) => SecondScreen(),
//           '/third': (context) => ThirdScreen(),
//         },
//       ),
//     ));

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettings()),
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: FirstApp(),
    ));

class FirstApp extends StatelessWidget {
  const FirstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: context.watch<AppSettings>().isDarkMode
            ? Brightness.dark
            : Brightness.light,
      ),
      routes: {
        '/': (context) => ToDoScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
      },
    );
  }
}


class ToDoProvider extends ChangeNotifier {
  List<ToDo> _todos = [];
  int _counter = 0;

  ToDoProvider() {
    this._todos = [
      ToDo(
        text: 'Buy milk 1',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 2',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
      ToDo(
        text: 'Buy milk 3',
        author: 'John',
      ),
    ];
  }

  List<ToDo> get todos => _todos;

  int get counter => _counter;

  void add(ToDo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void remove(ToDo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void removeAt(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettings, ToDoProvider>(builder: (cxt, appSettings, todoProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          actions: [
            Switch(
              value: appSettings.isDarkMode,
              onChanged: (value) {
                appSettings.toggleTheme();
              },
            ),
          ],
        ),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 90,
            // crossAxisSpacing: 20,
            // mainAxisSpacing: 20,
          ),
          physics: const BouncingScrollPhysics(),
          children: todoProvider.todos
              .mapIndexed((index, element) => ToDoCard(
            todo: element,
            index: index + 1,
            onDelete: () {
              todoProvider.removeAt(index);
            },
          ))
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/third');
          },
          child: const Icon(Icons.add_to_home_screen),
          backgroundColor: Colors.redAccent,
        ),
      );
    });
  }
}

class ToDoCard extends StatelessWidget {
  final ToDo todo;
  final int index;
  final VoidCallback onDelete;

  const ToDoCard({
    Key? key,
    required this.todo,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              index.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // todoObj.text
                              Text(
                                todo.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 6),
                              // todoObj.author
                              Text(
                                todo.author,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: onDelete,
                                color: Colors.grey[700],
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                )),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: const Center(
        child: Text('This is the second screen'),
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(builder: (context, todoProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Third Screen'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Icon(Icons.add_to_home_screen),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                todoProvider.counter.toString(),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  todoProvider.incrementCounter();
                },
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
