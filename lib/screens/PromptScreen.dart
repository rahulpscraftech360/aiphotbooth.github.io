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
                        _textController.clear();
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
        SnackBar(content: Text("Please select a prompt ")),
      );
      return;
    }

    try {
      // final response = await http.post(
      //   Uri.parse('https://localhost:3000/swap'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode({
      //     'image': widget.capturedImage,
      //     'prompt': _selectedPrompt.isNotEmpty
      //         ? _selectedPrompt
      //         : _textController.text,
      //   }),
      // );

      // if (response.statusCode == 200) {
      //   final responseData = json.decode(response.body);
      //   _responseImageUrl = responseData['imageUrl'];

      //   if (_responseImageUrl != null) {
      //     // Save the name and photo URL to Supabase
      //     await _saveDataToSupabase(
      //         widget.userName ?? 'Unknown User', _responseImageUrl!);

      // Pop the selected prompt back to the previous screen
      Navigator.pop(context, _selectedPrompt);

      // Optionally, you can navigate to the FinalScreen here if desired
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
      //   ),
      // );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text("Failed to retrieve image URL from response")),
      //   );
      // }
      // } else {
      //   await _saveDataToSupabase(
      //       widget.userName ?? 'Unknown User', "djsjkfsjkdfjdsbjk");
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content:
      //             Text("Failed to submit data. Error: ${response.statusCode}")),
      //   );
      // }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    }
  }

  // Function to save user data to Supabase
  Future<void> _saveDataToSupabase(String name, String imageUrl) async {
    try {
      final response = await Supabase.instance.client
          .from('users') // Replace 'users' with your Supabase table name
          .insert({
        'name': name,
        'photo_url': imageUrl,
      });

      if (response.error != null) {
        print("Error saving data to Supabase: ${response.error!.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save data to Supabase")),
        );
      } else {
        print("Data saved successfully to Supabase!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data saved successfully!")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("An unexpected error occurred while saving data")),
      );
    }
  }
}
