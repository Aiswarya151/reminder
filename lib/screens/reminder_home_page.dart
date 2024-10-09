import 'package:flutter/material.dart';
import '../models/reminder.dart'; // Import the Reminder model
import 'add_reminder_page.dart';

class ReminderHomePage extends StatefulWidget {
  @override
  _ReminderHomePageState createState() => _ReminderHomePageState();
}

class _ReminderHomePageState extends State<ReminderHomePage> {
  List<Reminder> reminders = [];

  // Callback to add a new reminder
  void _addReminder(Reminder reminder) {
    setState(() {
      reminders.add(reminder);
    });
  }

  // Callback to delete a reminder
  void _deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remind Me',
          style: TextStyle(
            color: Color(0xFF6E3F23), // Warm Brown for text
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFC9B29B), // Sand Dune Beige for AppBar background
      ),
      backgroundColor: Color.fromARGB(249, 250, 248, 243), // Light Sand for background color
      body: reminders.isEmpty
          ? Center(
              child: Text(
                'No reminders yet!',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6E3F23), // Warm Brown for text
                ),
              ),
            )
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return Card(
                  color: Color(0xFF5B9EA6), // Ocean Blue for card background
                  margin: EdgeInsets.symmetric(vertical: 38, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      reminder.title,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // White text for contrast
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${reminder.description} - ${reminder.dateTime.year}-${reminder.dateTime.month}-${reminder.dateTime.day} ${reminder.dateTime.hour}:${reminder.dateTime.minute}',
                      style: TextStyle(
                        color: Color(0xFFFAF3E0), // Light Sand for subtitle text
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white), // Delete icon
                      onPressed: () {
                        // Confirm deletion
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Deletion'),
                              content: Text('Are you sure you want to delete this reminder?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteReminder(index); // Call delete function
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), // To add some space from bottom
        child: FloatingActionButton.extended(
          onPressed: () async {
            // Navigate to AddReminderPage and wait for the reminder data
            final newReminder = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddReminderPage(),
              ),
            );

            // Debugging to check if newReminder is being returned
            print('New Reminder: $newReminder');

            // If a reminder is returned, add it to the list
            if (newReminder != null) {
              _addReminder(newReminder);
            }
          },
          label: Row(
            children: [
              Icon(Icons.add), // The '+' icon
              SizedBox(width: 8), // Space between icon and text
              Text('Add Reminder'),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 199, 228, 228), // Ocean Blue for FAB background
        ),
      ),
    );
  }
}
