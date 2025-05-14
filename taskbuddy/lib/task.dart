import 'package:flutter/material.dart';

class Task {
  final String taskName;
  final int index;
  final DateTime dueDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String description;

  Task({
    required this.taskName,
    required this.index,
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'index': index,
      'dueDate': dueDate.toIso8601String(),
      'startTime': '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
      'endTime': '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
      'description': description,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    // Parse the date
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(map['dueDate'] as String);
    } catch (e) {
      parsedDate = DateTime.now();
      print('Error parsing date: $e');
    }
    
    // Parse the start time
    TimeOfDay parseStartTime;
    try {
      if (map['startTime'] is String) {
        List<String> timeParts = map['startTime'].toString().split(':');
        if (timeParts.length == 2) {
          int hour = int.tryParse(timeParts[0]) ?? 0;
          int minute = int.tryParse(timeParts[1]) ?? 0;
          parseStartTime = TimeOfDay(hour: hour, minute: minute);
        } else {
          parseStartTime = TimeOfDay.now();
        }
      } else {
        parseStartTime = TimeOfDay.now();
      }
    } catch (e) {
      parseStartTime = TimeOfDay.now();
      print('Error parsing start time: $e');
    }
    
    // Parse the end time
    TimeOfDay parseEndTime;
    try {
      if (map['endTime'] is String) {
        List<String> timeParts = map['endTime'].toString().split(':');
        if (timeParts.length == 2) {
          int hour = int.tryParse(timeParts[0]) ?? 0;
          int minute = int.tryParse(timeParts[1]) ?? 0;
          parseEndTime = TimeOfDay(hour: hour, minute: minute);
        } else {
          parseEndTime = TimeOfDay.now();
        }
      } else {
        parseEndTime = TimeOfDay.now();
      }
    } catch (e) {
      parseEndTime = TimeOfDay.now();
      print('Error parsing end time: $e');
    }

    return Task(
      taskName: map['taskName'] ?? '',
      index: map['index'] ?? 0,
      dueDate: parsedDate,
      startTime: parseStartTime,
      endTime: parseEndTime,
      description: map['description'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Task{taskName: $taskName, index: $index, dueDate: $dueDate, startTime: $startTime, endTime: $endTime, description: $description}';
  }
}