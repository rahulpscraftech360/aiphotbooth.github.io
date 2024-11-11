// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart'; // For Android and iOS
// import 'package:simple_web_camera/simple_web_camera.dart'; // For Web

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera Capture Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CameraCapture(),
//     );
//   }
// }

// class CameraCapture extends StatefulWidget {
//   @override
//   _CameraCaptureState createState() => _CameraCaptureState();
// }

// class _CameraCaptureState extends State<CameraCapture> {
//   // For Android and iOS (using the camera package)
//   CameraController? _controller;
//   XFile? _image;
//   late List<CameraDescription> cameras;

//   // For Web (using simple_web_camera package)
//   String? _webCapturedImage;

//   @override
//   void initState() {
//     super.initState();
//     if (kIsWeb) {
//       // Initialize Web Camera (using simple_web_camera)
//       _initializeWebCamera();
//     } else {
//       // Initialize Android/iOS Camera (using camera package)
//       _initializeMobileCamera();
//     }
//   }

//   // For Web Camera Initialization (simple_web_camera package)
//   Future<void> _initializeWebCamera() async {
//     // No specific initialization needed for simple_web_camera
//   }

//   // For Android and iOS Camera Initialization (camera package)
//   Future<void> _initializeMobileCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.high);
//     await _controller?.initialize();
//   }

//   // Capture Image for Web (using simple_web_camera)
//   Future<void> _captureImageForWeb() async {
//     final capturedImage = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SimpleWebCameraPage(
//           appBarTitle: "Capture Photo",
//           centerTitle: true,
//         ),
//       ),
//     );
//     setState(() {
//       _webCapturedImage = capturedImage;
//     });
//   }

//   // Capture Image for Android/iOS (using camera package)
//   Future<void> _captureImageForMobile() async {
//     final XFile? image = await _controller?.takePicture();
//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Capture Image")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Platform-specific button for capturing image
//             kIsWeb
//                 ? ElevatedButton(
//                     onPressed: _captureImageForWeb,
//                     child: const Text("Capture Image (Web)"),
//                   )
//                 : ElevatedButton(
//                     onPressed: _captureImageForMobile,
//                     child: const Text("Capture Image (Android/iOS)"),
//                   ),
//             const SizedBox(height: 16),
//             // Display the captured image (Web or Mobile)
//             kIsWeb
//                 ? _webCapturedImage == null
//                     ? const Text("No image captured")
//                     : Image.memory(
//                         base64Decode(_webCapturedImage!),
//                       )
//                 : _image == null
//                     ? const Text("No image captured")
//                     : Image.file(File(_image!.path)),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     if (!kIsWeb) {
//       _controller?.dispose();
//     }
//     super.dispose();
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/screens/FinalScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/camera_capture_screen.dart';
import 'screens/web_camera_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Capture Example',
      theme: AppTheme.lightTheme, // Using a custom theme
      initialRoute: kIsWeb ? '/web' : '/', // If Web, go to /web; else go to /

      routes: {
        '/': (context) => CameraCaptureScreen(), // Main Camera Capture Screen
        '/web': (context) => WebCameraScreen(),
        '/final': (context) => FinalScreen(
            imageUrl:
                'https://example.com/your-image.jpg'), // Final result screen// Web Camera Screen
      },
    );
  }
}
