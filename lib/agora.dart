import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'agora_view.dart';

class Agora {
  static const MethodChannel _channel = const MethodChannel('agora');

  static Future<void> initAgoraEngine({
    @required String agoraId,
    bool isDebug = true,
  }) async {
    await _channel.invokeMethod('initEngine', <String, dynamic>{
      'agoraId': agoraId,
      'isDebug': isDebug,
    });
  }

  static Future<void> joinChannel({@required String channel}) async {
    await _channel.invokeMethod(
      'join_channel',
      <String, dynamic>{'channel_id': channel},
    );
  }

  static Future<void> leaveChannel() async {
    await _channel.invokeMethod('leave_channel');
  }
}
