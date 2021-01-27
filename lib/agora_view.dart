import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AgoraView extends StatefulWidget {
  @override
  _AgoraViewState createState() => _AgoraViewState();
}

class _AgoraViewState extends State<AgoraView> {
  @override
  Widget build(BuildContext context) {
    
    if (kIsWeb) {
      return HtmlElementView(
        viewType: "full-screen-video",
      );
    }
    throw UnimplementedError('Unknown platform: ${Platform.operatingSystem}');
  }
}
