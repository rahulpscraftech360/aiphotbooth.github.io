import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'FinalScreen.dart';
import 'PromptScreen.dart';
import 'package:simple_web_camera/simple_web_camera.dart';

class WebCameraScreen extends StatefulWidget {
  final String userName;

  WebCameraScreen({required this.userName}); // Accept userName in constructor

  @override
  _WebCameraScreenState createState() => _WebCameraScreenState();
}

class _WebCameraScreenState extends State<WebCameraScreen> {
  String? _webCapturedImage;
  String? _selectedPrompt = '';
  String? _responseImageUrl;
  bool _isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1080,
        height: 1920,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("background.png"), // Background image
            fit: BoxFit.contain,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
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
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _captureImageForWeb,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    255, 236, 236, 236), // Custom button color
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 25), // Adjusted padding
                                fixedSize: Size(
                                    678, 138), // Set fixed size for the button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Rounded corners for the button
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Centers the content
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 60, // Icon size
                                  ),
                                  SizedBox(
                                      width: 10), // Space between icon and text
                                  Text(
                                    "CAPTURE",
                                    style: TextStyle(
                                        fontSize: 60, // Text size
                                        color: (Color.fromARGB(255, 56, 90,
                                            64)) // Text color to match the icon
                                        ),
                                  ),
                                ],
                              ),
                            )
                          ])
                    : _isLoading
                        ? Center(
                            child: SizedBox(
                              width: 100.0, // Adjust the width as needed
                              height: 100.0, // Adjust the height as needed
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ) // Show loading indicator when loading
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 350),
                              Container(
                                width: 666,
                                height: 666,
                                decoration: BoxDecoration(
                                  color:
                                      Colors.grey, // Container background color
                                  border: Border.all(
                                    color: Colors.white, // White border color
                                    width: 10, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      16), // Rounded corners
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      16), // Ensure the image respects the border radius
                                  child: Image.memory(
                                    base64Decode(_webCapturedImage!),
                                    width: 666,
                                    height: 666,
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the container without distortion
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _retakeImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 236, 236,
                                      236), // Custom button color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 25), // Adjusted padding
                                  fixedSize: Size(678,
                                      138), // Set fixed size for the button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded corners for the button
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the content
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 60, // Icon size
                                    ),
                                    SizedBox(
                                        width:
                                            10), // Space between icon and text
                                    Text(
                                      "RETAKE",
                                      style: TextStyle(
                                          fontSize: 60, // Text size
                                          color: (Color.fromARGB(255, 56, 90,
                                              64)) // Text color to match the icon
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _openPromptScreen,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xFFFF6A13), // Custom button color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 25), // Adjusted padding
                                  fixedSize: Size(678,
                                      138), // Set fixed size for the button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded corners for the button
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the content
                                  children: [
                                    Text(
                                      "Custom Prompts",
                                      style: TextStyle(
                                          fontSize: 60, // Text size
                                          color: (Color.fromARGB(255, 255, 255,
                                              255)) // Text color to match the icon
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              // ElevatedButton(
                              //   onPressed: _aiMagic,
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Color.fromARGB(255, 255, 255,
                              //         255), // Custom button color
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: 50,
                              //         vertical: 25), // Adjusted padding
                              //     fixedSize: Size(678,
                              //         138), // Set fixed size for the button
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(
                              //           30), // Rounded corners for the button
                              //     ),
                              //   ),
                              //   child: const Row(
                              //     mainAxisAlignment: MainAxisAlignment
                              //         .center, // Centers the content
                              //     children: [
                              //       Text(
                              //         "AI Magic",
                              //         style: TextStyle(
                              //             fontSize: 60, // Text size
                              //             color: (Color.fromARGB(255, 0, 0,
                              //                 0)) // Text color to match the icon
                              //             ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              ElevatedButton(
                                onPressed: _aiMagic,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 255, 255,
                                      255), // Custom button color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 25), // Adjusted padding
                                  fixedSize: Size(678,
                                      138), // Set fixed size for the button
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Rounded corners for the button
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers the content
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'icon.png'), // Path to your icon image
                                      width: 60, // Adjust icon width
                                      height: 60, // Adjust icon height
                                    ),
                                    SizedBox(
                                        width:
                                            30), // Space between icon and text
                                    Text(
                                      "AI Magic",
                                      style: TextStyle(
                                        fontSize: 60, // Text size
                                        color: Color.fromARGB(255, 0, 0,
                                            0), // Text color to match the icon
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),
              // Top Left Logo
              Positioned(
                top: 16,
                left: 16,
                child: Image.asset('logo1.png', height: 45), // Left logo path
              ),
              // Top Right Logo
              Positioned(
                top: 16,
                right: 16,
                child: Image.asset('logo2.png', height: 45), // Right logo path
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
        builder: (context) => const SimpleWebCameraPage(centerTitle: false),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a prompt!',
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

    setState(() {
      _isLoading = true; // Start loading animation
    });

    try {
      final response = await http.post(
        Uri.parse('https://localhost:3000/swap'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'image': _webCapturedImage,
          'prompt': _selectedPrompt,
        }),
      );

      setState(() {
        _isLoading = false; // Stop loading animation
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _responseImageUrl = responseData['imageUrl'];

        if (_responseImageUrl != null) {
          // Navigate to the FinalScreen with the resulting image
          _saveDataToSupabase(widget.userName, _responseImageUrl!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
            ),
          );
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Failed to retrieve image URL from response"),
          // ));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinalScreen(imageUrl: _responseImageUrl),
            ),
          );
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Failed to submit data. Error: ${response.statusCode}"),
        // ));
      }
    } catch (error) {
      setState(() {
        _isLoading = false; // Stop loading animation
      });
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("An error occurred: $error"),
      // ));
      _saveDataToSupabase(widget.userName,
          "https://storage.googleapis.com/ai-photo-7495c.appspot.com/ig-ai-images/34177387-50fb-4ae4-9053-3d6d0c17d85e.png?Expires=1731486699&GoogleAccessId=firebase-adminsdk-jmozy%40ai-photo-7495c.iam.gserviceaccount.com&Signature=RKrdM660fmQul6SbGiJHG0mN%2Bzd%2BYUafM9OfgJMOhfB9wm98XHkQLi5JtyKQAsvK%2BkOKBdT0v55S5nyQeX9uTc%2B1Rj7vghKG2ZTIzwobQ2Z1qNf7r%2Bc2Xqhlrm6GCvIgDTiJJdq2eZP4WiETEcl5tQ2wixIxTeD%2BtClR%2BaH%2B61tCu62MeiTop5n8U9iteEG%2F%2F2SsyYT%2BHdGsDfm4Ap56nEZT5vF%2FSo3L2FZ52TpXS1yJNqPQz8g%2FCRPvK68GqlVMytAoPm5NCma7DsHv5t14VA8jab5HUXAHKVkwQuD8DH2KgY1WDIUmPe74SY10ANsqdzBV9R27fm2kYlB8q7DIJg%3D%3D");
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
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Failed to save data to Supabase")),
        // );
      } else {
        print("Data saved successfully to Supabase!");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Data saved successfully!")),
        // );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'An unexpected error occurred while saving data',
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
      ));
    }
  }
}
