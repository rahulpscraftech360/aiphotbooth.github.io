// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/PromptScreen.dart';
// import 'package:simple_web_camera/simple_web_camera.dart';

// class WebCameraScreen extends StatefulWidget {
//   @override
//   _WebCameraScreenState createState() => _WebCameraScreenState();
// }

// class _WebCameraScreenState extends State<WebCameraScreen> {
//   String? _webCapturedImage;

//   @override
//   void initState() {
//     super.initState();
//     _captureImageForWeb(); // Automatically capture image when the screen loads
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1C1C1C), // Dark background for sleek look
//       body: SafeArea(
//         child: Center(
//           child: _webCapturedImage == null
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.camera_alt,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Capture Your Image",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: _captureImageForWeb,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Color(0xFFFF6A13), // Custom button color
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       ),
//                       child: Text("Start Capture"),
//                     ),
//                   ],
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.memory(
//                       base64Decode(_webCapturedImage!),
//                       width: 300,
//                       height: 300,
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _retakeImage,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             Color(0xFFFF6A13), // Custom button color
//                       ),
//                       child: Text("Retake"),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _submitImage,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green, // Submit button color
//                       ),
//                       child: Text("Submit"),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   // Capture Image from the Web Camera
//   Future<void> _captureImageForWeb() async {
//     final capturedImage = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const SimpleWebCameraPage(
//           centerTitle: true,
//         ),
//       ),
//     );
//     setState(() {
//       _webCapturedImage = capturedImage;
//     });
//   }

//   // Retake the image by resetting the captured image
//   void _retakeImage() {
//     setState(() {
//       _webCapturedImage = null;
//     });
//     _captureImageForWeb(); // Automatically reopen the camera for retake
//   }

//   // Submit the captured image and navigate to the PromptScreen
//   void _submitImage() {
//     if (_webCapturedImage != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PromptScreen(capturedImage: _webCapturedImage),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please capture an image first!")),
//       );
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'FinalScreen.dart';
import 'PromptScreen.dart';
import 'package:simple_web_camera/simple_web_camera.dart';

class WebCameraScreen extends StatefulWidget {
  @override
  _WebCameraScreenState createState() => _WebCameraScreenState();
}

class _WebCameraScreenState extends State<WebCameraScreen> {
  String? _webCapturedImage;
  String? _selectedPrompt = '';
  String? _responseImageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1C), // Dark background for sleek look
      body: SafeArea(
        child: Center(
          child: _webCapturedImage == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Capture Your Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _captureImageForWeb,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFFF6A13), // Custom button color
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text("Start Capture"),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey,
                      width: 300,
                      height: 300,
                      child: Image.memory(
                        base64Decode(_webCapturedImage!),
                        width: 300,
                        height: 300,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _retakeImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFFF6A13), // Custom button color
                      ),
                      child: Text("Retake"),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _openPromptScreen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFFF6A13), // Custom button color
                      ),
                      child: Text("Custom Prompts"),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _aiMagic,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Submit button color
                      ),
                      child: Text("AI Magic"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // Capture Image from the Web Camera
  Future<void> _captureImageForWeb() async {
    final capturedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleWebCameraPage(centerTitle: true),
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
    _captureImageForWeb(); // Automatically reopen the camera for retake
  }

  // Open the prompt screen to select a custom prompt
  Future<void> _openPromptScreen() async {
    final prompt = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromptScreen(capturedImage: _webCapturedImage),
      ),
    );
    if (prompt != null) {
      setState(() {
        _selectedPrompt = prompt;
      });
    }
  }

  // Send the captured image and prompt to the backend
  Future<void> _aiMagic() async {
    if (_webCapturedImage == null ||
        _selectedPrompt == null ||
        _selectedPrompt!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please capture an image and select a prompt!"),
      ));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://localhost:3000/swap'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'image': _webCapturedImage,
          'prompt': _selectedPrompt,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _responseImageUrl = responseData['imageUrl'];

        if (_responseImageUrl != null) {
          // Navigate to the FinalScreen with the resulting image
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to retrieve image URL from response"),
          ));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to submit data. Error: ${response.statusCode}"),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $error"),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalScreen(
              imageUrl:
                  'https://storage.googleapis.com/ai-photo-7495c.appspot.com/ig-ai-images/34177387-50fb-4ae4-9053-3d6d0c17d85e.png?Expires=1731486699&GoogleAccessId=firebase-adminsdk-jmozy%40ai-photo-7495c.iam.gserviceaccount.com&Signature=RKrdM660fmQul6SbGiJHG0mN%2Bzd%2BYUafM9OfgJMOhfB9wm98XHkQLi5JtyKQAsvK%2BkOKBdT0v55S5nyQeX9uTc%2B1Rj7vghKG2ZTIzwobQ2Z1qNf7r%2Bc2Xqhlrm6GCvIgDTiJJdq2eZP4WiETEcl5tQ2wixIxTeD%2BtClR%2BaH%2B61tCu62MeiTop5n8U9iteEG%2F%2F2SsyYT%2BHdGsDfm4Ap56nEZT5vF%2FSo3L2FZ52TpXS1yJNqPQz8g%2FCRPvK68GqlVMytAoPm5NCma7DsHv5t14VA8jab5HUXAHKVkwQuD8DH2KgY1WDIUmPe74SY10ANsqdzBV9R27fm2kYlB8q7DIJg%3D%3D'),
        ),
      );
    }
  }
}
