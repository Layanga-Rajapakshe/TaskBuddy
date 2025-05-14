import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task extends StatefulWidget {
  final String taskName;
  final int index;

  const Task({super.key, required this.taskName, required this.index});  

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
            ? Color.fromARGB(255, 152, 183, 219)
            : (widget.index % 4 == 2)
                ? Color.fromARGB(255, 167, 214, 114)
                : (widget.index % 4 == 3)
                    ? Color.fromARGB(255, 235, 121, 83)
                    : Color.fromARGB(255, 247, 213, 76),
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
                        "2024/05/05",
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Icon(Icons.access_time),
                      Text(
                        "From: 12.05"
                      ),
                      Text(
                    "To: 05:05"
                    )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  "Here is the description",
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
