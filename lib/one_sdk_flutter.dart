import 'dart:async';
import 'dart:collection';
import 'package:flutter/services.dart';

class One {
  static const MethodChannel _channel = const MethodChannel('one_sdk_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String get pluginVersion {
    return "1.1.0";
  }

  static Future<Map> sendInteraction(String interactionPath, Map properties) async {
    var interactionPropertiesMap = <String, dynamic>{
      'interactionPath': interactionPath,
      'properties': properties
    };
    return _channel.invokeMethod('sendInteraction', interactionPropertiesMap);
  }

  static Future<String> sendResponseCode(String responseCode, String interactionPath) async {
    var responseCodeMap = <String, String>{
      'responseCode': responseCode,
      'interactionPath': interactionPath
    };
    return _channel.invokeMethod('sendResponseCode', responseCodeMap);
  }

  /// Configure Thunderhead logging
  static Future<void> setThunderheadLogLevel(bool allOrNone) async {
    var logMap = <String, bool>{'logLevel': allOrNone};
    var result = await _channel.invokeMethod('setLogLevel', logMap);
    print(result);
  }

  /// Configure the Thunderhead SDK.
  ///
  /// For more information on finding these parameters, see [Find the Information required when Integrating ONE with your Mobile Solutions](https://na5.thunderhead.com/one/help/conversations/how-do-i/mobile/one_integrate_mobile_find_integration_info/)
  static Future<void> initializeOne(
      String siteKey,
      String touchpoint,
      String apiKey,
      String sharedSecret,
      String userID,
      String host,
      bool adminMode) async {
    var initParameters = <String, Object>{
      'siteKey': siteKey,
      'touchpoint': touchpoint,
      'apiKey': apiKey,
      'sharedSecret': sharedSecret,
      'userID': userID,
      'host': host,
      'adminMode': adminMode
    };
    var result = await _channel.invokeMethod('initializeOne', initParameters);
    print(result);
  }

  /// Configure optOut settings.
  ///
  /// Privacy compliance method to completely stop tracking a customer's actions.
  /// By default, the Thunderhead SDK is opted in for all settings.
  static Future<void> optOut(bool optOut, [List<OneOptOptions> options]) async {
    List<String> optOutList = [];
    if (options != null) {
      for (var optOutOption in options) {
        optOutList.add(optOutOption.value);
      }
    }

    var optOutMap = <String, Object>{'optOut': optOut, 'options': optOutList};
    var result = await _channel.invokeMethod('optOut', optOutMap);
    print(result);
  }
}

/// OptOut configuration options.
///
/// [OneOptOptions.allTracking] : Opts out of all tracking.
///
/// [OneOptOptions.cityCountryDetection] : Use this option to opt an end-user out or in of all city/country level tracking.
///
/// [OneOptOptions.iOS_keychainTidStorage] : iOS specific option to opt out of keychain storage.
///
/// [OneOptOptions.iOS_pasteboardTidStorage] : iOS specific option to opt out of pasteboard tid storage.
enum OneOptOptions {
  allTracking,
  cityCountryDetection,
  iOS_keychainTidStorage,
  iOS_pasteboardTidStorage
}

extension StringValue on OneOptOptions {
  String get value {
    switch (this) {
      case OneOptOptions.allTracking:
        return "allTracking";
      case OneOptOptions.cityCountryDetection:
        return "cityCountryDetection";
      case OneOptOptions.iOS_pasteboardTidStorage:
        return "pasteboardTidStorage";
      case OneOptOptions.iOS_keychainTidStorage:
        return "keychainTidStorage";
      default:
        return "";
    }
  }
}
