import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('To-Do List')),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              buildTab('Monday'),
              buildTab('Tuesday'),
              buildTab('Wednesday'),
              buildTab('Thursday'),
              buildTab('Friday'),
              buildTab('Saturday'),
              buildTab('Sunday'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ToDoList(day: 'Monday'),
            ToDoList(day: 'Tuesday'),
            ToDoList(day: 'Wednesday'),
            ToDoList(day: 'Thursday'),
            ToDoList(day: 'Friday'),
            ToDoList(day: 'Saturday'),
            ToDoList(day: 'Sunday'),
          ],
        ),
      ),
    );
  }

  Widget buildTab(String day) {
    return Tab(
      child: Text(day),
    );
  }
}

class ToDoList extends StatefulWidget {
  final String day;

  const ToDoList({Key? key, required this.day}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> tasks = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Text('${index + 1}.'),
            title: Text(
              task.title,
              style: TextStyle(
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                decorationThickness: 2.5, // Increase the thickness of the line
              ),
            ),
            subtitle: Text(DateFormat('dd-MM-yyyy').format(DateTime.now())),
            onTap: () {
              setState(() {
                task.isCompleted = !task.isCompleted;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: _textEditingController,
                  onSubmitted: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        tasks.add(Task(title: value));
                      }
                      _textEditingController.clear();
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}
