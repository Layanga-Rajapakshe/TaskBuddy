import 'package:flutter/material.dart';
import 'package:taskbuddy/task.dart';
import 'package:intl/intl.dart';

class Tasktile extends StatelessWidget {
  final Task task;

  const Tasktile({Key? key, required this.task}) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (task.index % 4 == 1)
            ? const Color.fromARGB(255, 152, 183, 219)
            : (task.index % 4 == 2)
                ? const Color.fromARGB(255, 167, 214, 114)
                : (task.index % 4 == 3)
                    ? const Color.fromARGB(255, 235, 121, 83)
                    : const Color.fromARGB(255, 247, 213, 76),
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.taskName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  _formatDate(task.dueDate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 14.0,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16.0,
                  color: Colors.black,
                ),
                const SizedBox(width: 4.0),
                Text(
                  '${_formatTimeOfDay(task.startTime)} - ${_formatTimeOfDay(task.endTime)}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}