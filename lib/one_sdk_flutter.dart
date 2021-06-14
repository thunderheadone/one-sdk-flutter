import 'dart:async';
import 'dart:collection';
import 'package:flutter/services.dart';

class One {
  static const MethodChannel _channel =
      const MethodChannel('one_sdk_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String get pluginVersion  {
    return "Thunderhead 1.0.0";
  }

  static Future<String> sendInteraction(String interactionPath, Map properties) async  {
    var interactionPropertiesMap = <String, dynamic> {
      'interactionPath' : interactionPath,
      'properties' : properties
    };
    return _channel.invokeMethod('sendInteraction', interactionPropertiesMap);
  }

  static Future<void> setThunderheadLogLevel(bool allOrNone) async {
    var logMap = <String, bool> {
      'logLevel' : allOrNone
    };
    var result = await _channel.invokeMethod('setLogLevel', logMap);
    print(result);
  }

  static Future<void> initializeOne(
      String siteKey,
      String touchpoint,
      String apiKey,
      String sharedSecret,
      String userID,
      String host,
      bool adminMode) async {

    var initParameters  = <String, Object> {
      'siteKey' : siteKey,
      'touchpoint' : touchpoint,
      'apiKey' : apiKey,
      'sharedSecret' : sharedSecret,
      'userID' : userID,
      'host' : host,
      'adminMode' : adminMode
    };
    var result = await _channel.invokeMethod('initializeOne', initParameters);
    print(result);
  }

}
