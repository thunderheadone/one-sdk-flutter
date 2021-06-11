## iOS Add Flutter to App Example 
An example app that adds the [flutter_module_example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_module_example) Flutter project to demonstrate how to add a Flutter module to an existing iOS app with the Thunderhead ONE Flutter Plugin.

To get started and run this example app, [Flutter](https://flutter.dev/docs/get-started/install) installation is required.

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).

## Requirements
* Flutter Version: v1.22.0+ (stable). 
    * Note: Flutter v2.0.0+ has not yet been tested and may encounter build issues.

## Table of Contents 
* [Getting Started](#getting-started)
    * [Install Flutter Packages](#install-flutter-packages)
    * [Install Pods](#install-pods)
    * [Configure the ONE SDK](#configure-the-one-sdk)
      * [#1: Configure SDK in Flutter Module](#1-configure-sdk-in-flutter-module)
      * [#2: Configure SDK in iOS](#2-configure-sdk-in-ios)
    * [Run the iOS app](#run-the-ios-app)
* [Questions or need help](#questions-or-need-help)
    * [Thunderhead ONE Support](#thunderhead-one-support)
    * [Salesforce Interaction Studio Support](#salesforce-interaction-studio-support)

## Getting Started

### Install Flutter Packages
In Terminal, navigate to [`flutter_module_example`](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_module_example/) folder and run the following command:
```
$ flutter pub get
```

### Install Pods
In Terminal, navigate to [`ios-add-flutter-to-existing-app-example`](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/ios-add-flutter-to-existing-app-example) folder and run the following command:
```
$ pod install
```

### Configure the ONE SDK 
Now, with the ability to integrate Flutter piecewise within a native app, you can now configure the SDK in two places. 

#### #1: Configure SDK in Flutter Module
Open the module's [main.dart](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_module_example/lib/main.dart#L48)
to initialize the SDK using the integration parameters specific to your ONE environment.

```dart
  final String SITE_KEY = "ONE-XXXXXXXXXX-1022";
  final String TOUCHPOINT = "myAppsNameURI";
  final String API_KEY = "f713d44a-8af0-4e79-ba7e-xxxxxxxxx";
  final String SHARED_SECRET = "bb8bacb2-ffc2-4c52-aaf4-xxx";
  final String USER_ID = "yourUsername@yourCompanyName"; // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
  final String HOST = "https://xx.thunderhead.com";
```

#### #2: Configure SDK in iOS
Open [AppDelegate.swift](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/ios-add-flutter-to-existing-app-example/ios-add-flutter-to-existing-app-example/Add%20Flutter%20to%20Existing%20App%20Example/AppDelegate.swift#L26)
to initialize the SDK using the integration parameters specific to your ONE environment.

```swift
One.startSessionWithSK("ONE-XXXXXXXXXX-1022",
    uri:"myAppsNameURI",
    apiKey:"f713d44a-8af0-4e79-ba7e-xxxxxxxxxxxxxxxx",
    sharedSecret:"bb8bacb2-ffc2-4c52-aaf4-xxxxxxxxxxxxxxxx",
    userId:"api@yourCompanyName", // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
    adminMode:false,
    hostName:"xx.thunderhead.com"
)
```
* For more information on finding these parameters, see [Find the Information required when Integrating ONE with your Mobile Solutions](https://na5.thunderhead.com/one/help/conversations/how-do-i/mobile/one_integrate_mobile_find_integration_info/)


### Run the iOS app
Navigate to to [`ios-add-flutter-to-existing-app-example`](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/ios-add-flutter-to-existing-app-example)  folder and open `Add Flutter to Existing App Example.xcworkspace` in Xcode, then build and run the app.

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._

### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
