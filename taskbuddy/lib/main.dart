import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskbuddy/addTask.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskbuddy/task.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(), // Wrap your app
  ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Buddy',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> tasks = [];

  @override
  void initState(){
    super.initState();
    getTasks();
  }

  Future getTasks()  async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        tasks = prefs.getStringList('tasks') ?? [];
      });
  }

  Future deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tasks.removeAt(index);
    await prefs.setStringList('tasks', tasks);
    setState((){});
  }

  Widget list(){
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index){
        return row(context, index);
      },
    );
  }

  Widget row(BuildContext context, int index){
    return Dismissible(
      key: Key(tasks[index]),
      child: Task(taskName: tasks[index]),
      onDismissed: (direction) {
        String task = tasks[index];
        deleteTask(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$task deleted"),
            duration: const Duration(seconds: 1),
          ),
        );
        getTasks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery. of(context). size. height;
    double screenWidth = MediaQuery. of(context). size. width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.06),
                    child: Text(
                      "Task Buddy",
                      style: GoogleFonts.numans(
                        color: Colors.white,
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
                  height: screenHeight * 0.5, // or any height based on your layout
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
          color:  Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
