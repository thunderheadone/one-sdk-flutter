import 'dart:async';
import 'dart:collection';
import 'package:flutter/services.dart';

class OnePlugin {
  static const MethodChannel _channel =
      const MethodChannel('one_sdk_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String get pluginVersion  {
    return "Thunderhead 0.1.0.beta-1";
  }

  static Future<void> sendInteraction(String interactionPath) async {
    var interactionMap = <String, dynamic> {
      'interactionPath' : interactionPath
    };
    var result = await _channel.invokeMethod('sendInteraction', interactionMap);
    print(result);
  }

  static Future<int> sendProperties(String interactionPath, Map properties) async  {
    var interactionPropertiesMap = <String, dynamic> {
      'interactionPath' : interactionPath,
      'properties' : properties
    };
/*
    var result =  _channel.invokeMethod('sendInteractionResponse', interactionMap);
    return result;
*/
    return  _channel.invokeMethod('sendProperties', interactionPropertiesMap);
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
