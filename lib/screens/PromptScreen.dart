import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'FinalScreen.dart';

class PromptScreen extends StatefulWidget {
  final String? capturedImage;
  final String? userName;

  PromptScreen({this.capturedImage, this.userName});

  @override
  _PromptScreenState createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  TextEditingController _textController = TextEditingController();
  String _selectedPrompt = '';
  String? _responseImageUrl;

  final List<String> _prompts = [
    'prompt1',
    'prompt2',
    'prompt3',
    'prompt4',
    'prompt5',
    'prompt6',
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions dynamically
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 430),
                  Wrap(
                    spacing: screenWidth * 0.03,
                    runSpacing: screenHeight * 0.02,
                    children: _prompts.map((prompt) {
                      final isSelected = _selectedPrompt == prompt;
                      print(_selectedPrompt);
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? Colors.green
                              : const Color.fromARGB(255, 118, 120, 121),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                            horizontal: screenWidth * 0.06,
                          ),
                          minimumSize:
                              Size(screenWidth * 0.25, screenHeight * 0.07),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedPrompt = prompt;
                            _textController.clear();
                          });
                        },
                        child: Text(
                          prompt,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.8, // 80% of screen width
                      height: MediaQuery.of(context).size.height *
                          0.2, // 20% of screen height
                      child: TextField(
                        controller: _textController,
                        style:
                            TextStyle(fontSize: 40), // Set the font size here
                        decoration: InputDecoration(
                          hintText: 'Enter Custom Prompt',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedPrompt = value;
                          });
                        },
                      ),
                    ),
                  ),
                  // SizedBox(height: screenHeight * 0.04),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF4CAF50), // Set your custom background color
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.15,
                        vertical: screenHeight * 0.025,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      fixedSize:
                          Size(678, 140), // Set the fixed size of the button
                    ),
                    onPressed: _submitData,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors
                            .white, // Optional: set text color to contrast with background
                        fontSize: 40, // Optional: adjust font size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitData() async {
    if (widget.capturedImage == null || _selectedPrompt.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Please select a prompt or enter a custom one")),
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a prompt or enter a custom one',
            style: TextStyle(fontSize: 40), // Adjust font size for readability
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20, // Horizontal padding
            vertical: 15, // Vertical padding for added height
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // Rounded corners
          ),
          behavior:
              SnackBarBehavior.floating, // Floating style for better visibility
          margin: EdgeInsets.symmetric(
              horizontal: 50, vertical: 40), // Screen margins
          // Optional: change background color

          duration: Duration(seconds: 3), // Control duration as needed
        ),
      );
      return;
    }

    try {
      Navigator.pop(context, _selectedPrompt);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    }
  }
}
