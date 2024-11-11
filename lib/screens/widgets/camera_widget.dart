import 'package:flutter/material.dart';

class CameraWidget extends StatelessWidget {
  final String platformType;

  CameraWidget({required this.platformType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: platformType == "Web"
          ? Text("Web Camera Capture Widget")
          : Text("Mobile Camera Capture Widget"),
    );
  }
}
