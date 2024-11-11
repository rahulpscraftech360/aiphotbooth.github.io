// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:simple_web_camera/simple_web_camera.dart';

// class WebCameraScreen extends StatefulWidget {
//   @override
//   _WebCameraScreenState createState() => _WebCameraScreenState();
// }

// class _WebCameraScreenState extends State<WebCameraScreen> {
//   String? _webCapturedImage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Capture Image (Web)")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _captureImageForWeb,
//               child: Text("Capture Image"),
//             ),
//             _webCapturedImage == null
//                 ? Text("No image captured")
//                 : Image.memory(
//                     base64Decode(_webCapturedImage!),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

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
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/PromptScreen.dart';
import 'package:simple_web_camera/simple_web_camera.dart';
// Import your PromptScreen

class WebCameraScreen extends StatefulWidget {
  @override
  _WebCameraScreenState createState() => _WebCameraScreenState();
}

class _WebCameraScreenState extends State<WebCameraScreen> {
  String? _webCapturedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capture Image (Web)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _captureImageForWeb,
              child: Text("Capture Image"),
            ),
            _webCapturedImage == null
                ? Text("No image captured")
                : Column(
                    children: [
                      Image.memory(
                        base64Decode(_webCapturedImage!),
                        width: 300,
                        height: 300,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _retakeImage,
                        child: Text("Retake"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitImage,
                        child: Text("Submit"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // Capture Image from the Web Camera
  Future<void> _captureImageForWeb() async {
    final capturedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleWebCameraPage(
          appBarTitle: "Capture Photo",
          centerTitle: true,
        ),
      ),
    );
    setState(() {
      _webCapturedImage = capturedImage;
    });
  }

  // Retake the image by resetting the captured image
  void _retakeImage() {
    setState(() {
      _webCapturedImage = null;
    });
  }

  // Submit the captured image and navigate to the PromptScreen
  void _submitImage() {
    if (_webCapturedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PromptScreen(capturedImage: _webCapturedImage),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please capture an image first!")),
      );
    }
  }
}
