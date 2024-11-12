import 'package:flutter/material.dart';
import 'camera_capture_screen.dart'; // Import the CameraCaptureScreen
import 'web_camera_screen.dart'; // Import the WebCameraScreen

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  void _continue() {
    if (_nameController.text.isNotEmpty) {
      final userName = _nameController.text;
      // Check the platform and navigate to the appropriate screen
      if (Theme.of(context).platform == TargetPlatform.iOS ||
          Theme.of(context).platform == TargetPlatform.android) {
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => CameraCaptureScreen(userName: userName),
            builder: (context) => WebCameraScreen(userName: userName),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebCameraScreen(userName: userName),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your name',
            style: TextStyle(fontSize: 64), // Adjust font size for readability
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 1080,
            height: 1920,
            child: Stack(
              children: [
                // Background Image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('background.png'), // Background image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          'AI Photo Booth',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: 668,
                          height: 138,
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle:
                                  TextStyle(color: Colors.orange, fontSize: 60),
                              filled: true,
                              fillColor: const Color.fromARGB(33, 48, 48, 48),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        Container(
                          width: 668,
                          height: 138,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'button.png'), // Replace with your image path
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ElevatedButton(
                            onPressed: _continue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .transparent, // Make the button itself transparent
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation:
                                  0, // Remove shadow for a more integrated look with the background
                            ),
                            child: Text(
                              '',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
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
                  child:
                      Image.asset('logo2.png', height: 45), // Right logo path
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
