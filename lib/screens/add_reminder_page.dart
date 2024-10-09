import 'package:flutter/material.dart';
import '../models/reminder.dart'; // Import the Reminder model
import '/services/notification_service.dart'; // Import the Notification Service

class AddReminderPage extends StatefulWidget {
  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  // Function to select a date using showDatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }
  }

  // Function to select a time using showTimePicker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );
    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title input field
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            // Description input field
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            // Display selected date and time, and provide buttons to change them
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Selected Date: ${selectedDateTime.year}-${selectedDateTime.month}-${selectedDateTime.day}'),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Selected Time: ${selectedDateTime.hour}:${selectedDateTime.minute}'),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Button to add reminder
            ElevatedButton(
              onPressed: () {
                // Validate and add the reminder
                if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                  final newReminder = Reminder(
                    title: titleController.text,
                    description: descriptionController.text,
                    dateTime: selectedDateTime,
                  );

                  // Schedule the notification
                  NotificationService().scheduleNotification(selectedDateTime, newReminder.title, newReminder.description);

                  Navigator.of(context).pop(newReminder); // Pass the new reminder back to the previous screen
                }
              },
              child: Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
