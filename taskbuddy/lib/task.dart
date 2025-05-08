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
      padding: const EdgeInsets.all(8),
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
      height: screenHeight * 0.1,
      width: screenWidth * 0.9,
      child: Row(
        children: [
          Checkbox(
            value: status,
            onChanged: (value) {
              setState(() {
                status = value!;
              });
            },
          ),
          Text(
            widget.taskName,  
            style: GoogleFonts.numans(
              color: Colors.black,
              fontSize: screenWidth * 0.05,
              height: 1.0,
              decoration: status ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
