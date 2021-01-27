@JS()
library agora_rtc_engine;

import 'dart:async';
import 'dart:html';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui' as ui;

// import 'package:agora/agora_view.dart';
import 'package:agora/agora_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';

@JS()
external void initAgora(String agoraId, bool isDebug);
external void joinChannel(String channel);
external void leaveChannel();

/// A web implementation of the Agora plugin.
class AgoraWeb {
  static void registerWith(Registrar registrar) {
    ui.platformViewRegistry.registerViewFactory(
      "full-screen-video",
      (int viewId) => AgoraViewWeb().divElement,
    );

    final MethodChannel channel = MethodChannel(
      'agora',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = AgoraWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'initEngine':
        final arguments = call.arguments;
        print(arguments.toString());
        String agoraId = arguments["agoraId"];
        bool isDebug = arguments["isDebug"];
        return _initAgoraEngine(agoraId, isDebug);
        break;
      case 'join_channel':
        final arguments = call.arguments;
        String channel = arguments["channel_id"];
        return _joinAgoraChannel(channel);
        break;
      case 'leave_channel':
        return _leaveAgoraChannel();
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'agora for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  _initAgoraEngine(String agoraId, bool isDebug) {
    assert(agoraId != null);
    assert(isDebug != null);
    print("plugin was called*\nagora id: $agoraId \nisDebug: $isDebug,");
    initAgora(agoraId, isDebug);
  }

  _joinAgoraChannel(String channel) {
    assert(channel != null);
    print("join channel plugin was called");
    joinChannel(channel);
  }

  _leaveAgoraChannel() {
    print("Leaving agora channel");
    leaveChannel();
  }
}

class AgoraViewWeb {
  final DivElement divElement;

  AgoraViewWeb() : divElement = DivElement() {
    divElement.style.backgroundColor = "black";
    divElement.setAttribute("id", "full-screen-video");
  }
}
