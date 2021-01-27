import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:agora/agora.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> initAgora() async {
    try {
      await Agora.initAgoraEngine(
        agoraId: 'aab8b8f5a8cd4469a63042fcfafe7063',
        isDebug: true,
      );
    } catch(e) {
      print('failed to init agora#n${e.toString()}');
    }
  }

  Future<void> joinChannel() async {
    try {
      await Agora.joinChannel(channel: "test");
    } on PlatformException {
      print('Failed to join channel');
    }
  }

  Future<void> leaveChannel() async {
    try {
      await Agora.leaveChannel();
    } on PlatformException {
      print('Failed to leave channel.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running '),
              Card(
                child: SizedBox(
                  height: 600,
                  width: 500,
                  child: AgoraView(),
                ),
              ),
              FlatButton(
                onPressed: () {
                  joinChannel();
                },
                child: Text("Join channel"),
              ),
              FlatButton(
                onPressed: () {
                  leaveChannel();
                },
                child: Text("Leave channel"),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            initAgora();
          },
        ),
      ),
    );
  }
}
