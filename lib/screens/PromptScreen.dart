// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/FinalScreen.dart';
// import 'package:http/http.dart' as http; // For API call
// // Final screen to show the result image

// class PromptScreen extends StatefulWidget {
//   final String? capturedImage; // Capture image passed from WebCameraScreen

//   PromptScreen({this.capturedImage});

//   @override
//   _PromptScreenState createState() => _PromptScreenState();
// }

// class _PromptScreenState extends State<PromptScreen> {
//   TextEditingController _textController = TextEditingController();
//   String _selectedPrompt = ''; // The selected prompt
//   String? _responseImageUrl;

//   // List of predefined prompts for AI photobooth
//   final List<String> _prompts = [
//     'Vintage Style',
//     'Cyberpunk Look',
//     'Retro Aesthetic',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Select Prompt")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display the captured image
//             // widget.capturedImage != null
//             //     ? Image.memory(
//             //         base64Decode(widget.capturedImage!),
//             //         width: 300,
//             //         height: 300,
//             //       )
//             // : SizedBox.shrink(),

//             SizedBox(height: 20),

//             // Text field to type custom prompt
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Custom Prompt',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPrompt = value;
//                 });
//               },
//             ),

//             SizedBox(height: 20),

//             // Display predefined prompt buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: _prompts.map((prompt) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _selectedPrompt = prompt;
//                       });
//                     },
//                     child: Text(prompt),
//                   ),
//                 );
//               }).toList(),
//             ),

//             SizedBox(height: 20),

//             // Submit button
//             ElevatedButton(
//               onPressed: _submitData,
//               child: Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Submit the data (image and prompt) to an API
//   Future<void> _submitData() async {
//     if (widget.capturedImage == null || _selectedPrompt.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select a prompt and capture an image!")),
//       );
//       return;
//     }

//     // Create the API request
//     try {
//       // Replace with your API URL and request structure
//       final response = await http.post(
//         Uri.parse('https://your-api-endpoint.com/submit'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'image': widget.capturedImage,
//           'prompt':
//               _selectedPrompt.isEmpty ? _textController.text : _selectedPrompt,
//         }),
//       );

//       if (response.statusCode == 200) {
//         // If the API call is successful, parse the response
//         final responseData = json.decode(response.body);
//         setState(() {
//           _responseImageUrl =
//               responseData['imageUrl']; // Assuming the API returns a URL
//         });

//         // Navigate to the FinalScreen with the resulting image
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
//           ),
//         );
//       } else {
//         // If the API call fails
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to submit data")),
//         );
//       }
//     } catch (error) {
//       // If there's an error with the request
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred!")),
//       );
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/FinalScreen.dart';
import 'package:http/http.dart' as http;

class PromptScreen extends StatefulWidget {
  final String? capturedImage;

  PromptScreen({this.capturedImage});

  @override
  _PromptScreenState createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  TextEditingController _textController = TextEditingController();
  String _selectedPrompt = '';
  String? _responseImageUrl;

  final List<String> _prompts = [
    'Vintage Style',
    'Cyberpunk Look',
    'Retro Aesthetic',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Prompt")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter Custom Prompt',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedPrompt = value;
                });
              },
            ),

            SizedBox(height: 20),

            // Updated prompt buttons with background color change
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _prompts.map((prompt) {
                final isSelected = _selectedPrompt == prompt;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.green : null,
                      foregroundColor: isSelected ? Colors.white : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedPrompt = prompt;
                        _textController
                            .clear(); // Clear custom prompt when predefined is selected
                      });
                    },
                    child: Text(prompt),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _submitData,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    if (widget.capturedImage == null || _selectedPrompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a prompt and capture an image!")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://your-api-endpoint.com/submit'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'image': widget.capturedImage,
          'prompt':
              _selectedPrompt.isEmpty ? _textController.text : _selectedPrompt,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _responseImageUrl = responseData['imageUrl'];
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
            builder: (context) => FinalScreen(
                imageUrl:
                    'https://img.freepik.com/premium-photo/beautiful-fantasy-land-magical-world-background_783716-598.jpg'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit data")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred!")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalScreen(
              imageUrl:
                  "https://img.freepik.com/premium-photo/beautiful-fantasy-land-magical-world-background_783716-598.jpg"),
        ),
      );
    }
  }
}
