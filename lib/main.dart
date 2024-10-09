import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/notification_service.dart'; // Import the Notification Service

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that plugin services are initialized
  await NotificationService().initialize(); // Initialize the notification service
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Start with the Splash Screen
    );
  }
}
