// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class FinalScreen extends StatelessWidget {
//   final String? imageUrl;

//   FinalScreen({this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Top Section - Logos
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset('logo1.png', height: 50), // logo1
//                 Image.asset('logo2.png', height: 50), // logo2
//               ],
//             ),
//             SizedBox(height: 40),

//             // Image Preview Section
//             Container(
//               color: Colors.grey, // Placeholder for image
//               width: 300,
//               height: 300,
//               child: imageUrl != null
//                   ? Image.network(
//                       imageUrl!,
//                       width: 300,
//                       height: 300,
//                       fit: BoxFit.cover,
//                     )
//                   : Center(child: Text("No Image Available")),
//             ),
//             SizedBox(height: 40),

//             // Buttons Section (Restart, Retry, QR Code)
//             ElevatedButton(
//               onPressed: () {
//                 // Handle Restart Logic
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     Color(0xFFFF6A13), // Custom orange button color
//                 padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
//               ),
//               child: Text("Restart"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF3B3B3B), // Custom gray button color
//                 padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
//               ),
//               child: Text("Retry"),
//             ),
//             SizedBox(height: 40),

//             QrImageView(
//               data: imageUrl!,
//               version: QrVersions.auto,
//               size: 200.0,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Scan to Download",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/restart_widget.dart';
import 'package:qr_flutter/qr_flutter.dart'; // For QR Code generation

class FinalScreen extends StatelessWidget {
  final String? imageUrl;

  FinalScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      // Image Preview Section
                      const SizedBox(height: 450),
                      Container(
                        width: 600,
                        height: 600,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set your desired radius
                          child: Container(
                            color: Colors.grey, // Placeholder for image
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl!,
                                    width: 600,
                                    height: 600,
                                    fit: BoxFit.cover,
                                  )
                                : Center(child: Text("No Image Available")),
                          ),
                        ),
                      ),

                      SizedBox(height: 40),
                      // Buttons Section (Restart, Retry)
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Restart the app or navigation logic here
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color(0xFFFF6A13),
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 100, vertical: 15),
                      //   ),
                      //   child: Text("Restart"),
                      // ),
                      // SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pop(
                      //         context); // Go back to the previous screen
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Color.fromARGB(255, 216, 216, 216),
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 100, vertical: 15),
                      //   ),
                      //   child: Text("Retry"),
                      // ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize
                              .min, // To center the buttons in the row
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                RestartWidget.restartApp(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF6A13),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Icon(
                                Icons.home,
                                size: 80,
                              ), // Icon for restart
                            ),
                            SizedBox(
                                width: 20), // Space between buttons (optional)
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Go back to the previous screen
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 216, 216, 216),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Icon(
                                Icons.replay,
                                size: 80,
                              ), // Icon for retry
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),

                      // QR Code Section
                      if (imageUrl != null)
                        Container(
                          color:
                              Colors.white, // Set the background color to white
                          padding: EdgeInsets.all(
                              10), // Optional padding to give some space around the QR code
                          child: QrImageView(
                            data: 'gdbfgubsuigbuidbviudfbuidfbvidbfb',
                            version: QrVersions.auto,
                            size: 300.0,
                          ),
                        ),

                      Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize
                                  .min, // To center the buttons in the row
                              children: [
                            SizedBox(height: 10),
                            Text(
                              "Scan the QR to ",
                              style: TextStyle(
                                  color: Color(0xFFFF6A13), fontSize: 40),
                            ),
                            SizedBox(height: 10),
                            Text(
                              " Download Image",
                              style: TextStyle(
                                  color: Color(0xFFFF6A13), fontSize: 40),
                            ),
                          ]))
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
                child: Image.asset('logo2.png', height: 45), // Right logo path
              ),
            ],
          ),
        ),
      ),
    );
  }
}
