import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/screens/FinalScreen.dart';
import 'package:flutter_application_1/screens/restart_widget.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/camera_capture_screen.dart';
import 'screens/web_camera_screen.dart';
import 'theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://vfzahhknnbkkuwidgmfa.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZmemFoaGtubmJra3V3aWRnbWZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzOTQ0MzIsImV4cCI6MjA0Njk3MDQzMn0.1xBDtTprTlchZZ_rKzdSnoHWgYNEF_5sS9pxyOlCuro',
  );
  runApp(RestartWidget(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera Capture Example',
      theme: AppTheme.lightTheme,
      initialRoute: '/final',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/': (context) => CameraCaptureScreen(userName: "userName"),
        '/web': (context) => WebCameraScreen(userName: "userName"),
        '/final': (context) =>
            FinalScreen(imageUrl: 'https://example.com/your-image.jpg'),
      },
    );
  }
}
