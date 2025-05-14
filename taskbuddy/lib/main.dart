import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskbuddy/addTask.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskbuddy/task.dart';
import 'package:device_preview/device_preview.dart';
import 'package:taskbuddy/taskTile.dart' as taskTile;

void main() {
  runApp(
    DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(), 
  ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        textTheme: GoogleFonts.numansTextTheme(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Task Buddy"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];

  @override
  void initState(){
    super.initState();
    getTasks();
  }

  Future getTasks() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> tasksJsonList = prefs.getStringList('tasks') ?? [];

      setState(() {
        tasks = tasksJsonList.map((taskJson){
          Map<String, dynamic> taskMap = jsonDecode(taskJson);
          return Task.fromMap(taskMap);
        }).toList();
      });
      
  }

  Future deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasks.removeAt(index);
    await prefs.setStringList('tasks', tasks.map((task) => jsonEncode(task.toMap())).toList());
    setState((){});
  }

  Widget list(){
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          "No Current Tasks. Add New Task To See Here...",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index){
          return row(context, index);
        },
      );
    }
  }

  Widget row(BuildContext context, int index){
    return Dismissible(
      key: Key("task-${tasks[index].index}-${DateTime.now().millisecondsSinceEpoch}"),
      child: taskTile.Tasktile(task: tasks[index]),
      confirmDismiss: (direction) async {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this task?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    },
      onDismissed: (direction) {
        deleteTask(index);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Task deleted"),
            duration: Duration(seconds: 1),
          ),
        );
        getTasks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 238, 201),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 246, 238, 201),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.06),
                    child: Text(
                      "Task Buddy",
                      style: GoogleFonts.numans(
                        color: Colors.black,
                        fontSize: screenWidth * 0.2,
                        height: 1.0,
                      ),
                      softWrap: true,
                    ),
                  ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                SizedBox(
                  height: screenHeight * 0.5,
                  child: list(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const AddTask()
            )
          );
          getTasks();
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}