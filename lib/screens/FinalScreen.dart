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
import 'package:qr_flutter/qr_flutter.dart';

class FinalScreen extends StatelessWidget {
  final String? imageUrl;

  FinalScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Get the device screen size
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    // Make sure to scale to 1080x1920
    double aspectRatio = 1080 / 1920; // Based on your design

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Section - Logos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('logo1.png', height: 50), // logo1
                    Image.asset('logo2.png', height: 50), // logo2
                  ],
                ),
                SizedBox(height: 40),

                // Image Preview Section
                Container(
                  color: Colors.grey, // Placeholder for image
                  width: 300,
                  height: 300,
                  child: imageUrl != null
                      ? Image.network(
                          'https://storage.googleapis.com/ai-photo-7495c.appspot.com/ig-ai-images/34177387-50fb-4ae4-9053-3d6d0c17d85e.png?Expires=1731486699&GoogleAccessId=firebase-adminsdk-jmozy%40ai-photo-7495c.iam.gserviceaccount.com&Signature=RKrdM660fmQul6SbGiJHG0mN%2Bzd%2BYUafM9OfgJMOhfB9wm98XHkQLi5JtyKQAsvK%2BkOKBdT0v55S5nyQeX9uTc%2B1Rj7vghKG2ZTIzwobQ2Z1qNf7r%2Bc2Xqhlrm6GCvIgDTiJJdq2eZP4WiETEcl5tQ2wixIxTeD%2BtClR%2BaH%2B61tCu62MeiTop5n8U9iteEG%2F%2F2SsyYT%2BHdGsDfm4Ap56nEZT5vF%2FSo3L2FZ52TpXS1yJNqPQz8g%2FCRPvK68GqlVMytAoPm5NCma7DsHv5t14VA8jab5HUXAHKVkwQuD8DH2KgY1WDIUmPe74SY10ANsqdzBV9R27fm2kYlB8q7DIJg%3D%3D',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : Center(child: Text("No Image Available")),
                ),
                SizedBox(height: 40),

                // Buttons Section (Restart, Retry, QR Code)
                ElevatedButton(
                  onPressed: () {
                    RestartWidget.restartApp(context); // Restart the entire app
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFFF6A13), // Custom orange button color
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                  child: Text("Restart"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF3B3B3B), // Custom gray button color
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                  child: Text("Retry"),
                ),
                SizedBox(height: 40),

                // QR Code Section
                if (imageUrl != null)
                  QrImageView(
                    data: imageUrl!,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                SizedBox(height: 20),
                Text(
                  "Scan to Download",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
