import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskbuddy/task.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskController1 = TextEditingController();
  TextEditingController taskController2 = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? startTime, endTime;

  Future _addTask (Task task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasks = prefs.getStringList('tasks') ?? [];
    String taskJson = jsonEncode(task.toMap());
    tasks.add(taskJson);
    await prefs.setStringList('tasks', tasks);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme:const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 246, 238, 201),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: taskController1,
                decoration: const InputDecoration(
                  hintText: "Enter Task...",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    )
                  )
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select Date",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context, 
                        firstDate: DateTime(2000), 
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          dateController.text = "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                        });
                      }
                    }, 
                    icon: const Icon(Icons.calendar_month_rounded)
                  )
                )
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: startTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Start Time...",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            startTime = await showTimePicker(
                              context: context, 
                              initialTime: TimeOfDay.now()
                            );
                            if (startTime != null) {
                              setState(() {
                                startTimeController.text = startTime!.format(context);
                              });
                            }
                          }, 
                          icon: const Icon(Icons.access_time),
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Expanded(
                    child: TextField(
                      controller: endTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "End Time...",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            endTime = await showTimePicker(
                              context: context, 
                              initialTime: TimeOfDay.now()
                            );
                            if (endTime != null) {
                              setState(() {
                                endTimeController.text = endTime!.format(context);
                              });
                            }
                          }, 
                          icon: const Icon(Icons.access_time),
                        )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              TextField(
                controller: taskController2,
                decoration: const InputDecoration(
                  hintText: "Enter Description...",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: (){
                  String taskName = taskController1.text;
                  String description = taskController2.text;
                  int index = Random().nextInt(10); 
                  if(taskName.isNotEmpty && description.isNotEmpty){
                    Task task = Task(
                      taskName: taskName, 
                      index: index, dueDate: 
                      selectedDate ?? DateTime.now(), 
                      startTime: startTime ?? TimeOfDay.now(), 
                      endTime: endTime ?? TimeOfDay.now(), 
                      description: description
                    );
                    _addTask(task);
                    Navigator.pop(context);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a task"),
                        duration: Duration(seconds: 2),
                      )
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.2,
                  ),
                ),
                child:
                  const Text(
                    "Add Task",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}