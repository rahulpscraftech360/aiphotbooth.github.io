import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the qr_flutter package

class FinalScreen extends StatelessWidget {
  final String? imageUrl;

  FinalScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Scaffold(
      appBar: AppBar(title: Text("Final Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image
            imageUrl != null
                ? Image.network(imageUrl!,
                    width: 300, height: 300) // Display the result image
                : Text("No result image available, try again"),

            SizedBox(height: 20),

            // Generate QR Code for the image URL
            imageUrl != null
                ? Column(
                    children: [
                      Text("Scan this QR code to download the image:"),
                      SizedBox(height: 10),
                      // QrImage(
                      //   data:
                      //       imageUrl!, // Pass the image URL to the QR code generator
                      //   size: 200.0,
                      //   backgroundColor: Colors.white,
                      // ),
                      QrImageView(
                        data: imageUrl!,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ],
                  )
                : SizedBox.shrink(),

            SizedBox(height: 20),

            // Restart button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/'); // Navigate back to the home route
              },
              child: Text("Restart"),
            ),
          ],
        ),
      ),
    );
  }
}
