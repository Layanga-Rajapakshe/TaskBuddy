import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.075),
        color: Color.fromARGB(255, 235, 121, 83),
      ),
      height: screenHeight * 0.1,
      width: screenWidth * 0.9,
      child: Row(
        children: [
          Checkbox(
            value: false, 
            onChanged: (value){
              value = value!;
            }
          ),
          Text(
            "Sample Task",
            style: GoogleFonts.numans(
              color: Colors.black,
              fontSize: screenWidth * 0.05,
              height: 1.0,
            ),
          )
        ],
      ),
    );
  }
}