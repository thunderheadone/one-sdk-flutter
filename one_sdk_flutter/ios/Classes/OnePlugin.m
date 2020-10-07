#import "OnePlugin.h"
#import "Thunderhead/One.h"

@implementation OnePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"one_sdk_flutter"
            binaryMessenger:[registrar messenger]];
  OnePlugin* instance = [[OnePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"initializeOne" isEqualToString:call.method]) {
      [self initializeOne:call result:result];
  } else if ([@"setLogLevel" isEqualToString:call.method]) {
      [self setLogLevel:call result:result];
  } else if ([@"sendInteraction" isEqualToString:call.method]) {
      [self sendInteraction:call result:result];
  } else if ([@"sendProperties" isEqualToString:call.method]) {
      [self sendInteraction:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)initializeOne:(FlutterMethodCall *)call result:(FlutterResult) result
{
    NSString *siteKey = call.arguments[@"siteKey"];
    NSString *touchpointURI = call.arguments[@"touchpoint"];
    NSString *apikey = call.arguments[@"apiKey"];
    NSString *sharedSecret = call.arguments[@"sharedSecret"];
    NSString *userId = call.arguments[@"userID"];
    NSString *hostName = call.arguments[@"host"];
    NSNumber *adminMode = call.arguments[@"adminMode"];

    [One startSessionWithSK:siteKey
                        uri:touchpointURI
                     apiKey:apikey
               sharedSecret:sharedSecret
                     userId:userId
                  adminMode:adminMode.boolValue
                   hostName:hostName];

    [One disableAutomaticInteractionDetection:YES];
    
    result(nil);
}

- (void)setLogLevel:(FlutterMethodCall *)call result:(FlutterResult) result
{
    NSNumber *logLevel = call.arguments[@"logLevel"];
    [One setLogLevel:logLevel.boolValue ? kOneLogLevelAll : kOneLogLevelNone];
    result(nil);
}

- (void)sendInteraction:(FlutterMethodCall *)call result:(FlutterResult) result
{
    [self sendProperties:call result:result];
}

- (void)sendProperties:(FlutterMethodCall*)call result:(FlutterResult) result
{
    NSString *interactionPath = call.arguments[@"interactionPath"];
    NSDictionary *properties = call.arguments[@"properties"];
    
    if (!interactionPath.length) {
        return;
    }

    if (properties != nil && [properties isKindOfClass:[NSDictionary class]] && properties.count) {
        [One sendInteraction:interactionPath withProperties:properties andBlock:^(NSDictionary *response, NSError *error) {
            if (error) {
                result([FlutterError errorWithCode:[NSString stringWithFormat:@"Error: %ld", error.code]
                                           message:error.domain
                                           details:error.localizedDescription]);
            } else {
                [One processResponse:response];
                result(response[@"statusCode"]);
            }
        }];
    } else {
        [One sendInteraction:interactionPath withBlock:^(NSDictionary *response, NSError *error) {
            if (error) {
                result([FlutterError errorWithCode:[NSString stringWithFormat:@"Error: %ld", error.code]
                                           message:error.domain
                                           details:error.localizedDescription]);
            } else {
                result(response[@"statusCode"]);
            }
        }];
    }
}

//TODO: Implement
//- (void)sendBaseTouchpointProperties:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    NSDictionary *properties = [command.arguments objectAtIndex:0];
//
//    if ([properties isKindOfClass:[NSDictionary class]] && properties.count) {
//        [One sendBaseTouchpointProperties:properties];
//    }
//}
//
//- (void)getTid:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[One getTid]];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)clearUserProfile:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    [One clearUserProfile];
//
//    CDVPluginResult *result;
//    if (![One getTid].length) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    } else {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }
//
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)disableIdentityTransfer:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    NSNumber *disableIdentifyTransfer = [command.arguments objectAtIndex:0];
//    CDVPluginResult *result;
//
//    if (![disableIdentifyTransfer isKindOfClass:[NSNumber class]]) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The SDK cannot get boolean from user input to enable/disable identity transfer"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One disableIdentityTransfer:[disableIdentifyTransfer boolValue]];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)disableAutomaticOutboundLinkTracking:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    NSNumber *disableAutomaticOutboundLinkTracking = [command.arguments objectAtIndex:0];
//    CDVPluginResult *result;
//
//    if (![disableAutomaticOutboundLinkTracking isKindOfClass:[NSNumber class]]) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The SDK cannot get boolean from user input to enable/disable automatic outbound link tracking"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One disableAutomaticOutboundLinkTracking:[disableAutomaticOutboundLinkTracking boolValue]];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)handleURL:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    NSString *stringURL = [command.arguments objectAtIndex:0];
//    CDVPluginResult *result;
//
//    if (!stringURL || ![stringURL isKindOfClass:[NSString class]]) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The passed string URL is not a NSString object or nil"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    NSURL *url = [NSURL URLWithString:stringURL];
//    if (!url) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The passed string URL is not valid for creating NSURL object"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One handleURL:url];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)sendInteractionForOutboundLink:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    CDVPluginResult *result;
//
//    NSString *stringURL = [command.arguments objectAtIndex:0];
//    if (![stringURL isKindOfClass:[NSString class]] || ![NSURL URLWithString:stringURL]) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The SDK cannot send an interaction request for a provided URL string: it is either not a string or not valid for creating NSURL object"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One sendInteractionForOutboundLink:[NSURL URLWithString:stringURL]];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)getURLWithOneTid:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    NSString *urlString = [command.arguments objectAtIndex:0];
//
//    if (![urlString isKindOfClass:[NSString class]] || ![NSURL URLWithString:urlString]) {
//        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"A passed argument is not a string or valid URL string"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    NSURL *url = [NSURL URLWithString:urlString];
//
//    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[One getURLWithOneTid:url].absoluteString];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)enablePushNotifications:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    NSNumber *enablePushNotifications = [command.arguments objectAtIndex:0];
//    CDVPluginResult *result;
//
//    if (![enablePushNotifications isKindOfClass:[NSNumber class]]) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The ONE SDK can't get a boolean from the user input to enable/disable push notifications"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One enablePushNotifications:[enablePushNotifications boolValue]];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)getPushToken:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[One getPushToken]];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)sendPushToken:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    CDVPluginResult *result;
//
//    id pushToken = [command.arguments objectAtIndex:0];
//    if (!pushToken || (![pushToken isKindOfClass:[NSData class]] && ![pushToken isKindOfClass:[NSString class]])) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The SDK cannot send a request for a provided push token: it is either a nil or not a NSData or not a NSString object"];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    if ([pushToken isKindOfClass:[NSString class]]) {
//        const char *ptr = [pushToken cStringUsingEncoding:NSASCIIStringEncoding];
//        NSUInteger len = [pushToken length]/2;
//        NSMutableData *dataPushToken = [NSMutableData dataWithCapacity:len];
//        while(len--) {
//            char num[5] = (char[]){ '0', 'x', 0, 0, 0 };
//            num[2] = *ptr++;
//            num[3] = *ptr++;
//            uint8_t n = (uint8_t)strtol(num, NULL, 0);
//            [dataPushToken appendBytes:&n length:1];
//        }
//        [One sendPushToken:dataPushToken];
//    } else {
//        [One sendPushToken:pushToken];
//    }
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)whitelistIdentityTransferLinks:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    CDVPluginResult *result;
//
//    if (!command.arguments.count) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The SDK cannot whitelist any links as no links were provided."];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One whitelistIdentityTransferLinks:command.arguments];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}
//
//- (void)blacklistIdentityTransferLinks:(FlutterMethodCall *)call result:(FlutterResult) result
//{
//    CDVPluginResult *result;
//
//    if (!command.arguments.count) {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"The SDK cannot blacklist any links as no links were provided."];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//        return;
//    }
//
//    [One blacklistIdentityTransferLinks:command.arguments];
//
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}

@end
