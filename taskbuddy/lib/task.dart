import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task extends StatefulWidget {
  final String taskName;

  const Task({super.key, required this.taskName});

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
        color: const Color.fromARGB(255, 235, 121, 83),
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
