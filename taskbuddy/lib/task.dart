import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task extends StatefulWidget {
  final String taskName, description;
  final int index;
  final DateTime dueDate;
  final TimeOfDay startTime, endTime;

  const Task({super.key, required this.taskName, required this.index, required this.dueDate, required this.startTime, required this.endTime, required this.description});  

  Map<String, dynamic> toMap(){
    return {
      'taskName' : taskName,
      'index' : index,
      'dueDate' : dueDate.toIso8601String(),
      'startTime' : startTime.toString(),
      'endTime' : endTime.toString(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      taskName: map['title'], 
      index: map['index'],
      dueDate: map['dueDate'], 
      startTime: map['startTime'], 
      endTime: map['endTime'], 
      description: map['description']
    );
  }

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.075),
        color: (widget.index % 4 == 1)
            ? const Color.fromARGB(255, 152, 183, 219)
            : (widget.index % 4 == 2)
                ? const Color.fromARGB(255, 167, 214, 114)
                : (widget.index % 4 == 3)
                    ? const Color.fromARGB(255, 235, 121, 83)
                    : const Color.fromARGB(255, 247, 213, 76),
      ),
      width: screenWidth * 0.9,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskName,  
                  style: GoogleFonts.numans(
                    color: Colors.black,
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    decoration: status ? TextDecoration.lineThrough : null,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month),
                      Text(
                        widget.dueDate.toIso8601String(),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Icon(Icons.access_time),
                      Text(
                        "From: " + widget.startTime.toString()
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Text(
                    "To: " + widget.endTime.toString()
                    )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04
                  ),
                )
              ],
            ),
          ),
          Checkbox(
            value: status,
            onChanged: (value) {
              setState(() {
                status = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
