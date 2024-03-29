import 'dart:async';
import 'dart:collection';
import 'package:flutter/services.dart';

const String oneResponseTidKey = 'tid';
const String oneResponseInteractionPathKey = 'interactionPath';
const String oneResponseOptimizationPointsKey = 'optimizations';

const String oneOptimizationPointDataKey = 'data';
const String oneOptimizationPointPathKey = 'path';
const String oneOptimizationPointResponseIdKey = 'responseId';
const String oneOptimizationPointDataMimeTypeKey = 'dataMimeType';
const String oneOptimizationPointDirectivesKey = 'directives';
const String oneOptimizationPointNameKey = 'name';
const String oneOptimizationPointViewPointNameKey = 'viewPointName';
const String oneOptimizationPointViewPointIdKey = 'viewPointId';

class One {
  static const MethodChannel _channel = const MethodChannel('one_sdk_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String get pluginVersion {
    return "1.1.0";
  }

  /// Send an Interaction to the Thunderhead API.
  /// 
  /// Returns a [Future<Map>] containing response data.
  static Future<Map> sendInteraction(String interactionPath, [Map properties]) async {
    var interactionPropertiesMap = <String, dynamic>{
      'interactionPath': interactionPath,
      'properties': properties
    };
    return await _channel.invokeMethod('sendInteraction', interactionPropertiesMap);
  }

  /// Send an Response Code to the Thunderhead API.
  static Future<void> sendResponseCode(String responseCode, String interactionPath) async {
    var responseCodeMap = <String, String>{
      'responseCode': responseCode,
      'interactionPath': interactionPath
    };
    await _channel.invokeMethod('sendResponseCode', responseCodeMap);
  }

  /// Configure Thunderhead logging
  static Future<void> setThunderheadLogLevel(bool allOrNone) async {
    var logMap = <String, bool>{'logLevel': allOrNone};
    await _channel.invokeMethod('setLogLevel', logMap);
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
    await _channel.invokeMethod('initializeOne', initParameters);
  }

  /// Configure optOut settings.
  ///
  /// Privacy compliance method to completely stop tracking a customer's actions.
  /// By default, the Thunderhead SDK is opted in for all settings.
  ///
  /// When opted out, tracking will stop and locally queued data will be removed.
  /// At any point you can opt a user back in by passing false into the same method.
  static Future<void> optOut(bool optOut) async {
    var optOutMap = <String, Object>{'optOut': optOut};
    await _channel.invokeMethod('optOut', optOutMap);
  }

  /// Configure optOut settings for city/country level tracking.
  ///
  /// Enabled by default.
  static Future<void> optOutCityCountryDetection(bool optOut) async {
    var optOutMap = <String, Object>{'optOut': optOut};
    await _channel.invokeMethod('optOutCityCountryDetection', optOutMap);
  }

  /// Configure iOS platform specific optOut settings for keychain tid storage.
  ///
  /// Enabled by default.
  static Future<void> optOutKeychainTidStorage(bool optOut) async {
    var optOutMap = <String, Object>{'optOut': optOut};
    await _channel.invokeMethod('optOutKeychainTidStorage', optOutMap);
  }
}
