import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  Future<void> initialize() async {
    tz.initializeTimeZones(); // Initialize time zones

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Change icon as needed

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    // Initialize the plugin without the onSelectNotification parameter
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(DateTime dateTime, String title, String description) async {
    await flutterLocalNotificationsPlugin!.zonedSchedule(
      0, // Notification ID
      title,
      description,
      tz.TZDateTime.from(dateTime, tz.local), // Time of the notification
      NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel', // Channel ID
          'Reminder Notifications', // Channel Name
          channelDescription: 'Channel for Reminder Notifications', // Use named parameter for description
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
