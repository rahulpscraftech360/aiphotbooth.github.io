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
                      Container(
                        color: Colors.grey, // Placeholder for image
                        width: 300,
                        height: 300,
                        child: imageUrl != null
                            ? Image.network(
                                imageUrl!,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              )
                            : Center(child: Text("No Image Available")),
                      ),
                      SizedBox(height: 40),
                      // QR Code Section
                      if (imageUrl != null)
                        // QrImage(
                        //   data: imageUrl!,
                        //   version: QrVersions.auto,
                        //   size: 200.0,
                        // ),
                        QrImageView(
                          data: imageUrl!,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      SizedBox(height: 20),
                      Text(
                        "Scan the QR to Download Image",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 40),
                      // Buttons Section (Restart, Retry)
                      ElevatedButton(
                        onPressed: () {
                          // Restart the app or navigation logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6A13),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                        ),
                        child: Text("Restart"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Go back to the previous screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 216, 216, 216),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                        ),
                        child: Text("Retry"),
                      ),
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
