// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'widgets/camera_widget.dart';

// class CameraCaptureScreen extends StatefulWidget {
//   @override
//   _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
// }

// class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
//   CameraController? _controller;
//   XFile? _image;
//   late List<CameraDescription> cameras;

//   @override
//   void initState() {
//     super.initState();
//     _initializeMobileCamera();
//   }

//   Future<void> _initializeMobileCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.high);
//     await _controller?.initialize();
//   }

//   Future<void> _captureImageForMobile() async {
//     final XFile? image = await _controller?.takePicture();
//     setState(() {
//       _image = image;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Capture Image (Android/iOS)")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _captureImageForMobile,
//               child: Text("Capture Image"),
//             ),
//             _image == null
//                 ? Text("No image captured")
//                 : Image.file(File(_image!.path)),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/screens/PromptScreen.dart'; // Import PromptScreen

class CameraCaptureScreen extends StatefulWidget {
  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  CameraController? _controller;
  XFile? _image;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _initializeMobileCamera();
  }

  Future<void> _initializeMobileCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller?.initialize();
  }

  Future<void> _captureImageForMobile() async {
    final XFile? image = await _controller?.takePicture();
    setState(() {
      _image = image;
    });
  }

  // Retake the image by resetting the captured image
  void _retakeImage() {
    setState(() {
      _image = null;
    });
  }

  // Submit the captured image and navigate to the PromptScreen
  void _submitImage() {
    if (_image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PromptScreen(capturedImage: _image!.path),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please capture an image first!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capture Image (Android/iOS)")),
      body: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView to handle overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Capture image button
              SizedBox(height: 20),

              // Show the captured image with a fixed size and maintain aspect ratio
              _image == null
                  ? Text("No image captured")
                  : Container(
                      width: 550, // Limit the width
                      height: 550, // Limit the height
                      child: FittedBox(
                        fit: BoxFit.contain, // Preserve aspect ratio
                        child: Image.file(File(_image!.path)),
                      ),
                    ),

              SizedBox(height: 20),

              // Button for "Capture Image" or "Retake"
              _image == null
                  ? ElevatedButton(
                      onPressed: _captureImageForMobile,
                      child: Text("Capture Image"),
                    )
                  : ElevatedButton(
                      onPressed: _retakeImage,
                      child: Text("Retake"),
                    ),

              SizedBox(height: 20),

              // "Submit" button to navigate to the next screen
              _image != null
                  ? ElevatedButton(
                      onPressed: _submitImage,
                      child: Text("Submit"),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
